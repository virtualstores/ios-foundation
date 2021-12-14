// Double+SyntaxSugar.swift
// VSFoundation
//
// Created by CJ on 2021-12-09
// Copyright Virtual Stores - 2021
//

import Foundation

pulblic extension Double {
  var asFloat: Float {
    get {
      Float(self)
    }
  }
}