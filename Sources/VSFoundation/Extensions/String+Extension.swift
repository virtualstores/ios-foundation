//
//  String+Extension.swift
//  
//
//  Created by Théodore Roos on 2022-04-04.
//

import Foundation
import UIKit

public extension String {
  var asColor: UIColor {
    var colorString = trimmingCharacters(in: .whitespacesAndNewlines)
    colorString = colorString.replacingOccurrences(of: "#", with: "").uppercased()

//    print("colorString", colorString)
    let alpha: CGFloat = 1.0
    let red: CGFloat = self.colorComponentFrom(colorString: colorString, start: 0, length: 2)
    let green: CGFloat = self.colorComponentFrom(colorString: colorString, start: 2, length: 2)
    let blue: CGFloat = self.colorComponentFrom(colorString: colorString, start: 4, length: 2)

    let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    return color
  }

  func colorComponentFrom(colorString: String, start: Int, length: Int) -> CGFloat {
    let startIndex = colorString.index(colorString.startIndex, offsetBy: start)
    let endIndex = colorString.index(startIndex, offsetBy: length)
    let subString = colorString[startIndex..<endIndex]
    let fullHexString = length == 2 ? subString : "\(subString)\(subString)"
    var hexComponent: UInt64 = 0

    guard Scanner(string: String(fullHexString)).scanHexInt64(&hexComponent) else { return 0 }
    let hexFloat: CGFloat = CGFloat(hexComponent)
    let floatValue: CGFloat = CGFloat(hexFloat / 255.0)
//    print("floatValue", floatValue)
    return floatValue
  }
}
