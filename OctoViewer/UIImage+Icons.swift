//
//  UIImage+Icons.swift
//  OctoViewer
//
//  Created by Hesham Salman on 5/26/17.
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

import UIKit

public extension UIImage {

  /// Get a Octicons image with the given icon name, text color, size and an optional background color.
  ///
  /// - parameter name: The preferred icon name.
  /// - parameter textColor: The text color.
  /// - parameter size: The image size.
  /// - parameter backgroundColor: The background color (optional).
  /// - returns: A string that will appear as icon with Octicons
  public static func octicon(with icon: String, textColor: UIColor, size: CGSize, backgroundColor: UIColor = UIColor.clear) -> UIImage? {
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = NSTextAlignment.center
    let fontSize = min(size.width, size.height)
    let attributedString = NSAttributedString(string: icon, attributes: [NSFontAttributeName: UIFont.octicon(of: fontSize), NSForegroundColorAttributeName: textColor, NSBackgroundColorAttributeName: backgroundColor, NSParagraphStyleAttributeName: paragraph])
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    attributedString.draw(in: CGRect(x: 0, y: (size.height - fontSize) / 2, width: size.width, height: fontSize))
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }

}
