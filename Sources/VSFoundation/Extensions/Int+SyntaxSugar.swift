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

public extension UInt64 {
  static var nanoTime: UInt64 {
    var info = mach_timebase_info()
    guard mach_timebase_info(&info) == KERN_SUCCESS else { return 0 }
    return mach_absolute_time() * UInt64(info.numer) / UInt64(info.denom)
  }
}
