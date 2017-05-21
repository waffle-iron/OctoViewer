//
//  LaunchViewController.swift
//  OctoViewer
//
//  Created by Hesham Salman on 5/20/17.
//  Copyright © 2017 Hesham Salman. All rights reserved.
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
