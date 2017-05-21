//
//  LaunchViewModel.swift
//  OctoViewer
//
//  Created by Hesham Salman on 5/21/17.
//  Copyright © 2017 Hesham Salman. All rights reserved.
//

import Foundation
import Moya
import ReactiveCocoa
import ReactiveSwift
import Result

protocol LaunchViewModelInputs {
  var provider: ReactiveSwiftMoyaProvider<GitHubService> { get }
}

protocol LaunchViewModelOutputs {
  var koanText: SignalProducer<String, MoyaError> { get }
}

protocol LaunchViewModelType {
  var inputs: LaunchViewModelInputs { get }
  var outputs: LaunchViewModelOutputs { get }
}

final class LaunchViewModel: LaunchViewModelType, LaunchViewModelInputs, LaunchViewModelOutputs {

  init(provider: ReactiveSwiftMoyaProvider<GitHubService> = ReactiveSwiftMoyaProvider()) {
    self.provider = provider
    koanText = provider.request(.zen).mapString()
  }

  var provider: ReactiveSwiftMoyaProvider<GitHubService>
  let koanText: SignalProducer<String, MoyaError>

  var inputs: LaunchViewModelInputs { return self }
  var outputs: LaunchViewModelOutputs { return self }
}
