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
import ReactiveSwift
import Result

class OnlineProvider<Target>: ReactiveSwiftMoyaProvider<Target> where Target: TargetType {
  fileprivate let online: SignalProducer<Bool, NoError>

  init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
       requestClosure: @escaping RequestClosure = MoyaProvider.defaultRequestMapping,
       stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
       manager: Manager = ReactiveSwiftMoyaProvider<Target>.defaultAlamofireManager(),
       plugins: [PluginType] = [],
       trackInflights: Bool = false,
       online: SignalProducer<Bool, NoError> = connectedToInternetOrStubbing()) {
    self.online = online
  }

  override func request(_ token: Target) -> SignalProducer<Response, MoyaError> {
    let actualRequest = super.request(token)
    return online
      .skip(while: { !$0 })
      .take(first: 1).flatMap(.latest) { _ in
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

