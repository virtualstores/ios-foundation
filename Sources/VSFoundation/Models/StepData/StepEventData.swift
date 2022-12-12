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
  public let mlAdjustment: MLAdjustment?
  public let quaternion: [Double]

  public var distance: Double { speed ?? 0.0 * (Double(duration) / 1000) }

  public init(direction: Double?, directionCertainty: Double?, duration: Int64, relativeDirection: Double?, speed: Double?, stepCertainty: Double, success: Bool, timestamp: Int64, type: DeviceOrientation?, mlAdjustment: MLAdjustment?, quaternion: [Double]) {
    self.direction = direction
    self.directionCertainty = directionCertainty
    self.duration = duration
    self.relativeDirection = relativeDirection
    self.speed = speed
    self.stepCertainty = stepCertainty
    self.success = success
    self.timestamp = timestamp
    self.type = type
    self.mlAdjustment = mlAdjustment
    self.quaternion = quaternion
  }

  public struct MLAdjustment {
    public let speedModelFactor: Double
    public let speedAdjuster: Double
    public let driftInRadians: Double
    public let rotationInRadians: Double

    public init(speedModelFactor: Double, speedAdjuster: Double, driftInRadians: Double, rotationInRadians: Double) {
      self.speedModelFactor = speedModelFactor
      self.speedAdjuster = speedAdjuster
      self.driftInRadians = driftInRadians
      self.rotationInRadians = rotationInRadians
    }
  }
}
