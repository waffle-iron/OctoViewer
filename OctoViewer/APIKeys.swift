//
//  APIKeys.swift
//  OctoViewer
//
//  Created by Hesham Salman on 5/24/17.
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

private let minimumKeyLength = 2

// MARK: - API Keys 

struct APIKeys {
  let clientId: String
  let clientSecret: String

  fileprivate struct SharedKeys {
    static var instance = APIKeys()
  }

  static var sharedKeys: APIKeys {
    get {
      return SharedKeys.instance
    }

    set {
      SharedKeys.instance = newValue
    }
  }

  // MARK: - Methods 

  var stubResponses: Bool {
    return clientId.characters.count < minimumKeyLength || clientSecret.characters.count < minimumKeyLength
  }

  // MARK: - Initializers

  init(clientId: String, secret: String) {
    self.clientId = clientId
    clientSecret = secret
  }

  init() {
    guard let dictionary = Bundle.main.infoDictionary,
      let clientId = dictionary[Keys.clientId] as? String,
      let clientSecret = dictionary[Keys.clientSecret] as? String else {
      fatalError("Client ID and Secret don't exist in the current xcconfig or are not referenced in Info.plist")
    }
    self.init(clientId: clientId, secret: clientSecret)
  }
}

private struct Keys {
  static let clientId = "ClientId"
  static let clientSecret = "ClientSecret"
}
