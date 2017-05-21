//
//  LaunchViewControllerSpec.swift
//  OctoViewer
//
//  Created by Hesham Salman on 5/20/17.
//  Copyright © 2017 Hesham Salman. All rights reserved.
//

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
      controller.provider = MoyaProvider(stubClosure: MoyaProvider.immediatelyStub)
    }

    describe("networking") {

      beforeEach {
        controller.viewDidLoad()
      }

      it("fetches a value for the zen koan") {
        expect(controller.zenLabel.text).toNot(beNil())
      }
    }
  }
}
