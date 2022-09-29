//
//  StepEventData.swift
//  
//
//  Created by Théodore Roos on 2022-09-28.
//

import Foundation

public struct StepEventData {
  public let direction: Double?
  public let directionCertainty: Double?
  public let duration: Int64
  public let relativeDirection: Double?
  public let speed: Double?
  public let stepCertainty: Double
  public let success: Bool
  public let timestamp: Int64
  public let type: DeviceOrientation?

  public init(direction: Double?, directionCertainty: Double?, duration: Int64, relativeDirection: Double?, speed: Double?, stepCertainty: Double, success: Bool, timestamp: Int64, type: DeviceOrientation?) {
    self.direction = direction
    self.directionCertainty = directionCertainty
    self.duration = duration
    self.relativeDirection = relativeDirection
    self.speed = speed
    self.stepCertainty = stepCertainty
    self.success = success
    self.timestamp = timestamp
    self.type = type
  }
}
