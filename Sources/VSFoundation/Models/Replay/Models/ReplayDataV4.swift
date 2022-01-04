// ReplayDataV4.swift
// VSFoundation

// Created by: CJ on 2022-01-03
// Copyright (c) 2021 Virtual Stores

import Foundation

struct ReplaySensorDataFileV4: Codable {
  let qpsValues: String
  let versionOfVPS: String
  let systemType: String
  let replayData: ReplayDataV4
}

struct ReplayDataV4: Codable {
  let ACCELERATION: [ReplaySensorDataV4]
  let ROTATION: [ReplaySensorDataV4]
  let GRAVITY: [ReplaySensorDataV4]
}

struct ReplaySensorDataV4: Codable {
  let sensorTimestamp: Int
  let systemTimestamp: Int
  let values: [Double]
}

extension ReplaySensorDataFileV4 {
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