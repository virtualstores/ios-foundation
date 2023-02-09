// Int+SyntaxSugar.swift
// VSFoundation
//
// Created by CJ on 2021-12-09
// Copyright Virtual Stores - 2021
//

import Foundation

public extension Int {
  var asLong: Int64 { Int64(self) }
  var asFloat: Float { Float(self) }
  var asDouble: Double { Double(self) }
}
