// Double+LogicalEvaluation.swift
// VSFoundation
//
// Created by CJ on 2021-12-09
// Copyright Virtual Stores - 2021
//

import Foundation

public extension Double {
  static func logisticSigmoid(value: Double) -> Double {
    1 / (1 + exp(-value))
  }

  func sign() -> Double {
    switch self.sign {
    case .plus:
      return 1
    case .minus:
      return -1
    }
  }
}
