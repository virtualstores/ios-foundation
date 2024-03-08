// AltitudeSensorData.swift
// VSFoundation

// Created by: CJ on 2022-01-10
// Copyright (c) 2022 Virtual Stores

import Foundation
import CoreMotion

public struct AltitudeSensorData {
  public let timestampSensor: Int
  public let timestampLocal: Int
  public let timestampLocalNano: UInt64

  public let altitude: SensorData
  public let barometer: SensorData
  public let cmAltitude: CMAltitudeData

  public init(timestampSensor: Int, timestampLocal: Int, timestampLocalNano: UInt64, altitudeData: [Double], barometerData: [Double], cmAltitude: CMAltitudeData) {
    self.timestampSensor = timestampSensor
    self.timestampLocal = timestampLocal
    self.timestampLocalNano = timestampLocalNano
    self.altitude = SensorData(type: .altitude, data: altitudeData, timestampSensor: timestampSensor, timestampLocal: timestampLocal)
    self.barometer = SensorData(type: .barometer, data: barometerData, timestampSensor: timestampSensor, timestampLocal: timestampLocal)
    self.cmAltitude = cmAltitude
  }
}
