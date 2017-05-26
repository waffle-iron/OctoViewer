//
//  SafariPresenter.swift
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
import SafariServices

class SafariPresenter: NSObject {
  func safariViewController(for url: URL) {
    let controller = SFSafariViewController(url: url)
    controller.delegate = self
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
}

// MARK: - SFSafariViewControllerDelegate

extension SafariPresenter: SFSafariViewControllerDelegate {
  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
}
