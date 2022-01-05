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

  func trim(trimStrategy: TrimStrategy) -> ReplayDataV2 {

    let min = min(min(ACCELERATION.count, ROTATION.count), GRAVITY.count)

    return ReplayDataV2(
      ACCELERATION: ACCELERATION.trim(trimSize: (ACCELERATION.count - min), trimStrategy: trimStrategy),
      ROTATION: ROTATION.trim(trimSize: (ROTATION.count - min), trimStrategy: trimStrategy),
      GRAVITY: GRAVITY.trim(trimSize: (GRAVITY.count - min), trimStrategy: trimStrategy)
    )
  }
}

struct ReplaySensorDataV2: Codable {
  let first: Int
  let second: [Double]
}

extension ReplayDataV2 {
  func asMotionSensorData() -> [MotionSensorData]? {

    var result = [MotionSensorData]()
    if ACCELERATION.count == ROTATION.count &&
        ACCELERATION.count == GRAVITY.count {
      for index in ACCELERATION.indices {
        result.append(
            MotionSensorData(
              timestampSensor: ACCELERATION[index].first,
              timestampLocal: 0,
              accelerationData: ACCELERATION[index].second,
              gravityData: GRAVITY[index].second,
              rotationData: ROTATION[index].second
            )
        )
      }
      return result
    }
    return nil
  }
}