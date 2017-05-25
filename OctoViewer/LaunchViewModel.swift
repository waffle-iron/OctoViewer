//
//  LaunchViewModel.swift
//  OctoViewer
//
//  Created by Hesham Salman on 5/21/17.
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
//

import Foundation
import Moya
import RxSwift
import Result

protocol LaunchViewModelInputs {
  func loginButtonTapped()
  var provider: RxMoyaProvider<GitHubService> { get }
}

protocol LaunchViewModelOutputs {
  var koanText: Observable<String> { get }
}

protocol LaunchViewModelType {
  var inputs: LaunchViewModelInputs { get }
  var outputs: LaunchViewModelOutputs { get }
}

final class LaunchViewModel: LaunchViewModelType, LaunchViewModelInputs, LaunchViewModelOutputs {

  init(provider: RxMoyaProvider<GitHubService> = RxMoyaProvider()) {
    self.provider = provider
    koanText = provider.request(.zen).mapString()
  }

  var provider: RxMoyaProvider<GitHubService>
  let koanText: Observable<String>

  private let loginButtonTappedProperty = Variable()
  func loginButtonTapped() {
    loginButtonTappedProperty.value = ()
  }

  var inputs: LaunchViewModelInputs { return self }
  var outputs: LaunchViewModelOutputs { return self }
}
