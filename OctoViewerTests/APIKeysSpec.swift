//
//  APIKeysSpec.swift
//  OctoViewer
//
//  Created by Hesham Salman on 5/25/17.
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


import Quick
import Nimble

@testable import OctoViewer
class APIKeysSpec: QuickSpec {
  override func spec() {
    var keys: APIKeys!

    describe("initializers") {
      context("default init") {
        beforeEach {
          keys = APIKeys()
        }

        it("assigns values from the bundle dictionary") {
          let clientId = Bundle.main.infoDictionary!["ClientId"] as! String
          let clientSecret = Bundle.main.infoDictionary!["ClientSecret"] as! String
          expect(keys.clientId).to(equal(clientId))
          expect(keys.clientSecret).to(equal(clientSecret))
        }
      }
    }

    describe("Response Stubbing") {
      var keys: APIKeys!

      context("when the response should be stubbed") {
        it("stubs when client id is short") {
          keys = APIKeys(clientId: ".", secret: "|")
          expect(keys.stubResponses).to(beTruthy())
        }

        it("does not stub when client id is long") {
          keys = APIKeys()
          expect(keys.stubResponses).to(beFalsy())
        }
      }

      context("when the response should not be stubbed") {

      }
    }

  }
}
