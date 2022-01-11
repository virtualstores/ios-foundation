// AltitudeSensorData.swift
// VSFoundation

// Created by: CJ on 2022-01-10
// Copyright (c) 2022 Virtual Stores

import Foundation

public struct AltitudeSensorData {

  public let timestampSensor: Int
  public let timestampLocal: Int
  public let altitude : SensorData

  public init(timestampSensor: Int, timestampLocal: Int, altitudenData: [Double]) {
    self.timestampSensor = timestampSensor
    self.timestampLocal = timestampLocal
    self.altitude = SensorData(type: .altitude, data: altitudenData, timestampSensor: timestampSensor, timestampLocal: timestampLocal)
  }
}
