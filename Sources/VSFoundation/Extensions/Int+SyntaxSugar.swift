// Int+SyntaxSugar.swift
// VSFoundation
//
// Created by CJ on 2021-12-09
// Copyright Virtual Stores - 2021
//

import Foundation

public extension Int {
  var asInt32: Int32 { Int32(self) }
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

public extension Int64 {
  static var nanoTime: Int64 { Int64(UInt64.nanoTime) }
  static var currentTimeMillis: Int64 { Int64(Date().currentTimeMillis) }
}
