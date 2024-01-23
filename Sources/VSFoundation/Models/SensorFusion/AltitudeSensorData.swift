// AltitudeSensorData.swift
// VSFoundation

// Created by: CJ on 2022-01-10
// Copyright (c) 2022 Virtual Stores

import Foundation
import CoreMotion

public struct AltitudeSensorData {
  public let timestampSensor: Int
  public let timestampLocal: Int
  public let altitude: SensorData
  public let cmAltitude: CMAltitudeData

  public init(timestampSensor: Int, timestampLocal: Int, altitudenData: [Double], cmAltitude: CMAltitudeData) {
    self.timestampSensor = timestampSensor
    self.timestampLocal = timestampLocal
    self.altitude = SensorData(type: .altitude, data: altitudenData, timestampSensor: timestampSensor, timestampLocal: timestampLocal)
    self.cmAltitude = cmAltitude
  }
}
