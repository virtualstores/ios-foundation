// Int+SyntaxSugar.swift
// VSFoundation
//
// Created by CJ on 2021-12-09
// Copyright Virtual Stores - 2021
//

import Foundation

extension Int {
  var asFloat: Float {
    get { return Float(self) }
  }

  var asDouble: Double {
    get { return Double(self) }
  }
}