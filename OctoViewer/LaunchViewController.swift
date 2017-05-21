//
//  LaunchViewController.swift
//  OctoViewer
//
//  Created by Hesham Salman on 5/20/17.
//  Copyright © 2017 Hesham Salman. All rights reserved.
//

import UIKit
import Moya

class LaunchViewController: UIViewController {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var zenLabel: UILabel!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var signupButton: UIButton!

  var provider: MoyaProvider<GitHubService> = MoyaProvider()

  override func viewDidLoad() {
    super.viewDidLoad()
    configureZenLabel()
  }

  private func configureZenLabel() {
    provider.request(.zen) { [weak self] result in
      if case let .success(moyaResponse) = result {
        self?.zenLabel.text = try? moyaResponse.mapString()
      }
    }
  }
}
