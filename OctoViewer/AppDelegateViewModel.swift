//
//  AppDelegateViewModel.swift
//  OctoViewer
//
//  Created by Hesham Salman on 5/26/17.
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

import RxSwift
import Moya

protocol AppDelegateViewModelInputs {
  func application(app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool
  var provider: RxMoyaProvider<GitHubService> { get }

}

protocol AppDelegateViewModelOutputs {

}

protocol AppDelegateViewModelType {
  var inputs: AppDelegateViewModelInputs { get }
  var outputs: AppDelegateViewModelOutputs { get }
}

final class AppDelegateViewModel: AppDelegateViewModelType, AppDelegateViewModelInputs, AppDelegateViewModelOutputs {

  init(provider: RxMoyaProvider<GitHubService> = RxMoyaProvider()) {
    self.provider = provider
  }

  var provider: RxMoyaProvider<GitHubService>

  func application(app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
    let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
    if let urlComponents = urlComponents,
      let items = urlComponents.queryItems,
      let item = items.filter({ $0.name == "code" }).first, url.host == "auth" {
      Authenticate.shared.code = item.value
      requestAuthenticationToken(provider: provider)
    }
    return true
  }

  var inputs: AppDelegateViewModelInputs { return self }
  var outputs: AppDelegateViewModelOutputs { return self }
}

private func requestAuthenticationToken(provider: RxMoyaProvider<GitHubService>) {
  _ = provider.request(.authenticate)
      .mapString()
      .subscribe { event in
        guard case let .next(response) = event else {
          return
        }
        let set = CharacterSet(charactersIn: "=&?")
        let keys = response.components(separatedBy: set).enumerated().flatMap { $0.offset % 2 == 0 ? $0.element : nil }
        let values = response.components(separatedBy: set).enumerated().flatMap { $0.offset % 2 != 0 ? $0.element : nil }
        Authenticate.shared.accessToken = values[keys.index(of: "access_token")!]
    }
}
