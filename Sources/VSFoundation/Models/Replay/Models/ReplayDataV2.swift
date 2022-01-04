// ReplayDataV2.swift
// VSFoundation

// Created by: CJ on 2022-01-03
// Copyright (c) 2021 Virtual Stores

import Foundation

struct ReplaySensorDataFileV2: Codable {
  let qpsValues: String
  let versionOfVPS: String
  let systemType: String
  let sensorData: ReplayDataV2
}

struct ReplayDataV2: Codable {
  let ACCELERATION: [ReplaySensorDataV2]
  let ROTATION: [ReplaySensorDataV2]
  let GRAVITY: [ReplaySensorDataV2]
}

struct ReplaySensorDataV2: Codable {
  let first: Int
  let second: [Double]
}

extension ReplaySensorDataFileV2 {
  func asMotionSensorData() -> [MotionSensorData]? {
    var result = [MotionSensorData]()
    if sensorData.ACCELERATION.count == sensorData.ROTATION.count &&
        sensorData.ACCELERATION.count == sensorData.GRAVITY.count {
      for index in sensorData.ACCELERATION.indices {
        result.append(
            MotionSensorData(
              timestampSensor: sensorData.ACCELERATION[index].first,
              timestampLocal: 0,
              accelerationData: sensorData.ACCELERATION[index].second,
              gravityData: sensorData.GRAVITY[index].second,
              rotationData: sensorData.ROTATION[index].second
            )
        )
      }
      return result
    }
    return nil
  }
}