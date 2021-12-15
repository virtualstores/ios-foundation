// Float+SyntaxSugar.swift
// VSFoundation
//
// Created by CJ on 2021-12-09
// Copyright Virtual Stores - 2021
//

import Foundation

public extension Float {
  var asDouble: Double {
    get { return Double(self) }
  }
}
