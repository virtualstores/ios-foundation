// Double+CollectionsSyntaxSugar.swift
// VSFoundation
//
// Created by CJ on 2021-12-09
// Copyright Virtual Stores - 2021
//

import Foundation

public extension Array where Element == Double {
  func copy() -> [Double] {
    self.map { $0 }
  }
}
public extension Array where Element == [Double] {
  func copy() -> [[Double]] {
    self.map { $0 }
  }
}
