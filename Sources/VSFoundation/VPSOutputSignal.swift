//
//  VPSOutputSignal.swift
//  
//
//  Created by Théodore Roos on 2023-05-23.
//

import Foundation

public enum VPSOutputSignal {
  public struct Position {
    public let position: CGPoint
    public let std: Double
    public let status: Status

    public init(position: CGPoint, std: Double, status: Status) {
      self.position = position
      self.std = std
      self.status = status
    }

    public enum Status {
      case confident, uncertain
    }
  }

  case position(position: Position)
  case rotation(heading: Double)
}
