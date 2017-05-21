//
//  LaunchViewControllerSpec.swift
//  OctoViewer
//
//  Created by Hesham Salman on 5/20/17.
//  Copyright © 2017 Hesham Salman. All rights reserved.
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
