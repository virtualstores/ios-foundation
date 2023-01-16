//
//  PersonalMLData.swift
//  
//
//  Created by Théodore Roos on 2022-12-05.
//

import Foundation

public struct PersonalMLDataDTO: Codable {
  public let version: String
  public var timestamp: Double
  public let mlAlgoTag: PersonalMLAlgorithm
  public let deviceOrientation: DeviceOrientation
  public let speedModifier: Double
  public let angleModifier: Double
  public let driftModifier: Double
  public let properties: [String: Double]

  public init(version: String, timestamp: Double, mlAlgoTag: PersonalMLAlgorithm, deviceOrientation: DeviceOrientation, speedModifier: Double, angleModifier: Double, driftModifier: Double, properties: [String : Double]) {
    self.version = version
    self.timestamp = timestamp
    self.mlAlgoTag = mlAlgoTag
    self.deviceOrientation = deviceOrientation
    self.speedModifier = speedModifier
    self.angleModifier = angleModifier
    self.driftModifier = driftModifier
    self.properties = properties
  }
}
