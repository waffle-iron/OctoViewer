//
//  LaunchViewController.swift
//  OctoViewer
//
//  Created by Hesham Salman on 5/20/17.
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

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result
import Moya

class LaunchViewController: UIViewController {

  var viewModel: LaunchViewModelType = LaunchViewModel()
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet weak var zenLabel: UILabel!
  @IBOutlet private weak var loginButton: UIButton!
  @IBOutlet private weak var signupButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.outputs.koanText.start { [weak self] event in
      if case let .value(response) = event {
        self?.zenLabel.text = response
      }
    }
  }

  @IBAction
  func loginButtonTapped(_ sender: UIButton) {

  }

  @IBAction
  func signupButtonTapped(_ sender: UIButton) {

  }

}
