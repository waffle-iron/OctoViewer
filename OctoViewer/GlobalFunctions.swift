//
//  GlobalFunctions.swift
//  OctoViewer
//
//  Created by Hesham Salman on 5/24/17.
//  Copyright © 2017 Hesham Salman
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import Moya
import ReachabilitySwift
import RxSwift
import Result

// Ideally a Pod. For now a file.
func delayToMainThread(_ delay: Double, closure:@escaping () -> Void) {
  DispatchQueue.main.asyncAfter (
    deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

private let reachabilityManager = ReachabilityManager()

// An observable that completes when the app gets online (possibly completes immediately).
func connectedToInternetOrStubbing() -> Observable<Bool> {

  let stubbing = Observable.just(APIKeys.sharedKeys.stubResponses)

  guard let online = reachabilityManager?.reach else {
    return stubbing
  }

  return [online, stubbing].combineLatestOr()
}

func responseIsOK(_ response: Response) -> Bool {
  return response.statusCode == 200
}

func detectDevelopmentEnvironment() -> Bool {
  var developmentEnvironment = false
  #if DEBUG || (arch(i386) || arch(x86_64)) && os(iOS)
    developmentEnvironment = true
  #endif
  return developmentEnvironment
}

private class ReachabilityManager {

  private let reachability: Reachability

  let _reach = ReplaySubject<Bool>.create(bufferSize: 1)
  var reach: Observable<Bool> {
    return _reach.asObservable()
  }

  init?() {
    guard let r = Reachability() else {
      return nil
    }
    self.reachability = r

    do {
      try self.reachability.startNotifier()
    } catch {
      return nil
    }

    self._reach.onNext(self.reachability.isReachable)

    self.reachability.whenReachable = { _ in
      DispatchQueue.main.async { self._reach.onNext(true) }
    }

    self.reachability.whenUnreachable = { _ in
      DispatchQueue.main.async { self._reach.onNext(false) }
    }
  }

  deinit {
    reachability.stopNotifier()
  }
}

func bindingErrorToInterface(_ error: Swift.Error) {
  let error = "Binding error to UI: \(error)"
  #if DEBUG
    fatalError(error)
  #else
    print(error)
  #endif
}

// Applies an instance method to the instance with an unowned reference.
func applyUnowned<Type: AnyObject, Parameters, ReturnValue>(_ instance: Type, _ function: @escaping ((Type) -> (Parameters) -> ReturnValue)) -> ((Parameters) -> ReturnValue) {
  return { [unowned instance] parameters -> ReturnValue in
    return function(instance)(parameters)
  }
}
