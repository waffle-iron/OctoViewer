//
//  LaunchViewControllerSpec.swift
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

import Foundation
import Nimble
import Moya
import Quick
import ReusableViews

@testable import OctoViewer
class LaunchViewControllerSpec: QuickSpec {
  override func spec() {
    var controller: LaunchViewController!
    beforeEach {
      controller = UIStoryboard(name: "Splash", bundle: OctoViewer.bundle).instantiateViewControllerOfType(LaunchViewController.self)
      controller.loadView()
      controller.viewModel = LaunchViewModel(provider:  ReactiveSwiftMoyaProvider(stubClosure: MoyaProvider.immediatelyStub))
    }

    describe("networking") {

      beforeEach {
        controller.viewDidLoad()
      }

      it("fetches a value for the zen koan") {
        expect(controller.zenLabel.text).toNot(beNil())
      }
    }

    describe("navigation bar visibility") {
      beforeEach {
        _ = UINavigationController(rootViewController: controller)
      }
      
      context("when the view is visible") {
        beforeEach {
          controller.viewWillAppear(false)
        }

        it("has a hidden navigation bar") {
          expect(controller.navigationController?.isNavigationBarHidden).to(beTrue())
        }
      }

      context("when the view is not visible") {
        beforeEach {
          controller.viewWillDisappear(false)
        }

        it("has a visible navigation bar") {
          expect(controller.navigationController?.isNavigationBarHidden).to(beFalse())
        }
      }
    }

  }
}
