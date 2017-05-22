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
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var zenLabel: UILabel!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var signupButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.outputs.koanText.start { [weak self] event in
      switch event {
      case let .value(response):
        self?.zenLabel.text = response
      case let .failed(error):
        print("Zen Error: \(error)")
      default:
        break
      }
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }

}
