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
    public let timestamp: Date

    public init(position: CGPoint, std: Double, status: Status, timestamp: Date) {
      self.position = position
      self.std = std
      self.status = status
      self.timestamp = timestamp
    }

    public enum Status {
      case confident, uncertain, none
    }
  }

  case position(position: Position)
  case ux(position: Position)
  case ml(position: Position)
  case rotation(heading: Double)
}
