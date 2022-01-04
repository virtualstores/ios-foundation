// ReplayDataV5.swift
// VSFoundation

// Created by: CJ on 2022-01-03
// Copyright (c) 2021 Virtual Stores

import Foundation

struct ReplaySensorDataFileV5: Codable {
  let qpsValues: String
  let versionOfVPS: String
  let systemType: String
  let replayData: ReplayDataV5
}

struct ReplayDataV5: Codable {
  let ACCELERATION: [ReplaySensorDataV5]
  let ROTATION: [ReplaySensorDataV5]
  let GRAVITY: [ReplaySensorDataV5]
}

struct ReplaySensorDataV5: Codable {
  let sensorTimestamp: Int
  let systemTimestamp: Int
  let values: [Double]
  let sensorAccuracy: Int
}

extension ReplaySensorDataFileV5 {
  func asMotionSensorData() -> [MotionSensorData]? {
    var result = [MotionSensorData]()
    if replayData.ACCELERATION.count == replayData.ROTATION.count &&
         replayData.ACCELERATION.count == replayData.GRAVITY.count {
      for index in replayData.ACCELERATION.indices {
        result.append(
          MotionSensorData(
            timestampSensor: replayData.ACCELERATION[index].sensorTimestamp,
            timestampLocal: replayData.ACCELERATION[index].systemTimestamp,
            accelerationData: replayData.ACCELERATION[index].values,
            gravityData: replayData.GRAVITY[index].values,
            rotationData: replayData.ROTATION[index].values
          )
        )
      }
      return result
    }
    return nil
  }
}