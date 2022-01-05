// Collections+SyntaxSugar.swift
// VSFoundation
//
// Created by CJ on 2022-01-04
// Copyright Virtual Stores - 2022
//

import Foundation
import SwiftUI

public extension Array {
  func trim(trimSize: Int, trimStrategy: TrimStrategy) -> [Element] {
    switch trimStrategy {
    case .front:
      return Array(self[trimSize..<count])
    case .end:
      return Array(self[0..<count - trimSize])
    }
  }

  func copy() -> [Element] {
    self.map { $0 }
  }
}

public extension Sequence where Element: AdditiveArithmetic {
  /// Returns the total sum of all elements in the sequence
  func sum() -> Element { reduce(.zero, +) }
}

public extension Collection where Element: BinaryInteger {
  /// Returns the average of all elements in the array
  func average() -> Element { isEmpty ? .zero : sum() / Element(count) }
  /// Returns the average of all elements in the array as Floating Point type
  func average<T: FloatingPoint>() -> T { isEmpty ? .zero : T(sum()) / T(count) }
}

public extension Collection where Element: BinaryFloatingPoint {
  /// Returns the average of all elements in the array
  func average() -> Element { isEmpty ? .zero : sum() / Element(count) }
}
