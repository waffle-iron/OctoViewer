//
//  Authenticate.swift
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

import Foundation

struct Authenticate {

  struct Keys {
    static let code = "code"
    static let scope = "scope"
    static let clientId = "client_id"
    static let clientSecret = "client_secret"

    static let authToken = "auth_token"
  }

  fileprivate struct SharedAuthenticator {
    static var instance = Authenticate()
  }

  static var shared: Authenticate {
    get {
      return SharedAuthenticator.instance
    }

    set {
      SharedAuthenticator.instance = newValue
    }
  }

  var code: String?

  var clientId: String {
    guard let clientId = Bundle.main.infoDictionary?["ClientId"] as? String else {
      fatalError()
    }
    return clientId
  }

  var clientSecret: String {
    guard let clientSecret = Bundle.main.infoDictionary?["ClientSecret"] as? String else {
      fatalError()
    }
    return clientSecret
  }

  var scopes: String {
    return "repo"
  }

  var accessToken: String? {
    get {
      return UserDefaults.standard.string(forKey: Keys.authToken)
    }

    set {
      UserDefaults.standard.set(newValue, forKey: Keys.authToken)
    }
  }

  var initialLoginUrl: URL {
    return URL(string: "https://www.github.com/login/oauth/authorize?\(Keys.clientId)=\(clientId)&\(Keys.scope)=\(scopes)")!
  }

  var isLoggedIn: Bool {
    return accessToken != nil
  }
}
