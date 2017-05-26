//
//  GitHubService.swift
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
import Moya

enum GitHubService {
  case zen
  case authenticate
}

// MARK: - TargetType Protocol Implementation
//swiftlint:disable force_unwrapping
extension GitHubService: TargetType {
  var baseURL: URL {
    switch self {
    case .authenticate:
      return URL(string: "https://github.com")!
    default:
      return URL(string: "https://api.github.com")!
    }
  }

  var path: String {
    switch self {
    case .authenticate:
      return "/login/oauth/access_token"
    case .zen:
      return "/zen"
    }
  }

  var method: Moya.Method {
    switch self {
    case .zen:
      return .get
    case .authenticate:
      return .post
    }
  }

  var parameters: [String : Any]? {
    switch self {
    case .zen:
      return nil
    case .authenticate:
      return [
        Authenticate.Keys.clientId: Authenticate.shared.clientId,
        Authenticate.Keys.clientSecret: Authenticate.shared.clientSecret,
        Authenticate.Keys.code: Authenticate.shared.code!
      ]
    }
  }

  var parameterEncoding: ParameterEncoding {
    switch self {
    case .zen:
      return URLEncoding.default // Send parameters in URL, JSONEncoding.default to send JSON in request body
    case .authenticate:
      return JSONEncoding.default
    }
  }

  var sampleData: Data {
    switch self {
    case .zen:
      return "Half measures are as bad as nothing at all.".utf8Encoded
    case .authenticate:
      return "access_token=XYZ_ABC_123_MJ_N_ME&scope=repo&token_type=bearer".utf8Encoded
    }
  }

  var task: Task {
    switch self {
    case .zen, .authenticate:
      return .request
    }
  }
}

// MARK: - Helpers

private extension String {
  var urlEscaped: String {
    return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }

  var utf8Encoded: Data {
    return self.data(using: .utf8)!
  }
}
