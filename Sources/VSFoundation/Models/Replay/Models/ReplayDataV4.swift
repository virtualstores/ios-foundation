// ReplayDataV4.swift
// VSFoundation

// Created by: CJ on 2022-01-03
// Copyright (c) 2021 Virtual Stores

import Foundation

struct ReplaySensorDataFileV4: Codable {
  let qpsValues: String
  let versionOfVPS: String
  let systemType: String
  let sensorData: ReplayDataV4
  let startPosition: ReplayStartPosition
}

struct ReplayDataV4: Codable {
  let ACCELERATION: [ReplaySensorDataV4]
  let ROTATION: [ReplaySensorDataV4]
  let GRAVITY: [ReplaySensorDataV4]

  func trim(trimStrategy: TrimStrategy) -> ReplayDataV4 {
    let min = min(min(ACCELERATION.count, ROTATION.count), GRAVITY.count)

    return ReplayDataV4(
      ACCELERATION: ACCELERATION.trim(trimSize: (ACCELERATION.count - min), trimStrategy: trimStrategy),
      ROTATION: ROTATION.trim(trimSize: (ROTATION.count - min), trimStrategy: trimStrategy),
      GRAVITY: GRAVITY.trim(trimSize: (GRAVITY.count - min), trimStrategy: trimStrategy)
    )
  }
}

struct ReplaySensorDataV4: Codable {
  let sensorTimestamp: Int
  let systemTimestamp: Int
  let values: [Double]
}

extension ReplayDataV4 {
  func asMotionSensorData() -> [MotionSensorData]? {

    var result = [MotionSensorData]()
    if ACCELERATION.count == ROTATION.count &&
         ACCELERATION.count == GRAVITY.count {
      for index in ACCELERATION.indices {
        result.append(
          MotionSensorData(
            timestampSensor: ROTATION[index].sensorTimestamp,
            timestampLocal: ROTATION[index].systemTimestamp,
            timestampLocalNano: .nanoTime,
            accelerationData: ACCELERATION[index].values,
            gravityData: GRAVITY[index].values,
            rotationData: ROTATION[index].values,
            rotationRateData: [],
            accelerometerData: [],
            magnetometerData: []
          )
        )
      }
      return result
    }
    return nil
  }
}
