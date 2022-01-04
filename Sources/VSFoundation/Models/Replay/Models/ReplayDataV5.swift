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

  func trim(trimStrategy: TrimStrategy) -> ReplayDataV5 {

    let largest = max(max(ACCELERATION.count, ROTATION.count), GRAVITY.count)

    return ReplayDataV5(
      ACCELERATION: ACCELERATION.trim(trimSize: (largest - ACCELERATION.count), trimStrategy: trimStrategy),
      ROTATION: ROTATION.trim(trimSize: (largest - ROTATION.count), trimStrategy: trimStrategy),
      GRAVITY: GRAVITY.trim(trimSize: (largest - GRAVITY.count), trimStrategy: trimStrategy)
    )
  }
}

struct ReplaySensorDataV5: Codable {
  let sensorTimestamp: Int
  let systemTimestamp: Int
  let values: [Double]
  let sensorAccuracy: Int
}



extension ReplayDataV5 {
  func asMotionSensorData() -> [MotionSensorData]? {
    var result = [MotionSensorData]()
    if ACCELERATION.count == ROTATION.count &&
         ACCELERATION.count == GRAVITY.count {
      for index in ACCELERATION.indices {
        result.append(
          MotionSensorData(
            timestampSensor: ACCELERATION[index].sensorTimestamp,
            timestampLocal: ACCELERATION[index].systemTimestamp,
            accelerationData: ACCELERATION[index].values,
            gravityData: GRAVITY[index].values,
            rotationData:ROTATION[index].values
          )
        )
      }
      return result
    }
    return nil
  }
}
