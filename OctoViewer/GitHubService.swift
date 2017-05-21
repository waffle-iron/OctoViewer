//
//  GitHubService.swift
//  OctoViewer
//
//  Created by Hesham Salman on 5/20/17.
//  Copyright © 2017 Hesham Salman. All rights reserved.
//

import Foundation
import Moya

enum GitHubService {
  case zen
}

// MARK: - TargetType Protocol Implementation

extension GitHubService: TargetType {
  var baseURL: URL { return URL(string: "https://api.github.com")! }

  var path: String {
    switch self {
    case .zen:
      return "/zen"
    }
  }

  var method: Moya.Method {
    switch self {
    case .zen:
      return .get
    }
  }

  var parameters: [String : Any]? {
    switch self {
    case .zen:
      return nil
    }
  }

  var parameterEncoding: ParameterEncoding {
    switch self {
    case .zen:
      return URLEncoding.default // Send parameters in URL, JSONEncoding.default to send JSON in request body
    }
  }

  var sampleData: Data {
    switch self {
    case .zen:
      return "Half measures are as bad as nothing at all.".utf8Encoded
    }
  }

  var task: Task {
    switch self {
    case .zen:
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
