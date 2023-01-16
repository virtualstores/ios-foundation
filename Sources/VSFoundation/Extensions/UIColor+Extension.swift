//
//  UIColor+Extension.swift
//  
//
//  Created by Théodore Roos on 2022-03-21.
//

import Foundation
import UIKit

public extension UIColor {
    var asHex: String {
      let components = self.cgColor.components
      let r: CGFloat = components?[0] ?? 0.0
      let g: CGFloat = components?[1] ?? 0.0
      let b: CGFloat = components?[2] ?? 0.0

      let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
//      print("hexString", hexString)
      return hexString
    }
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
