//
//  Networking.swift
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

import Foundation
import Moya
import ReachabilitySwift
import RxSwift

class OnlineProvider<Target>: RxMoyaProvider<Target> where Target: TargetType {

  fileprivate let online: Observable<Bool>

  init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
       requestClosure: @escaping RequestClosure = MoyaProvider.defaultRequestMapping,
       stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
       manager: Manager = RxMoyaProvider<Target>.defaultAlamofireManager(),
       plugins: [PluginType] = [],
       trackInflights: Bool = false,
       online: Observable<Bool> = connectedToInternetOrStubbing()) {

    self.online = online
    super.init(endpointClosure: endpointClosure,
               requestClosure: requestClosure,
               stubClosure: stubClosure,
               manager: manager,
               plugins: plugins,
               trackInflights: trackInflights)
  }

  override func request(_ token: Target) -> Observable<Moya.Response> {
    let actualRequest = super.request(token)
    return online
      .ignore(value: false)  // Wait until we're online
      .take(1)        // Take 1 to make sure we only invoke the API once.
      .flatMap { _ in // Turn the online state into a network request
        return actualRequest
    }

  }
}

protocol NetworkingType {
  associatedtype T: TargetType
  var provider: OnlineProvider<T> { get }
}

struct Networking: NetworkingType {
  typealias T = GitHubService
  let provider: OnlineProvider<GitHubService>
}
