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
  let startPosition: ReplayStartPosition
}

struct ReplayDataV5: Codable {
  let ACCELERATION: [ReplaySensorDataV5]
  let ROTATION: [ReplaySensorDataV5]
  let GRAVITY: [ReplaySensorDataV5]
  let ALTITUDE: [ReplaySensorDataV5]

  func trim(trimStrategy: TrimStrategy) -> ReplayDataV5 {
    let min = min(min(ACCELERATION.count, ROTATION.count), GRAVITY.count)

    return ReplayDataV5(
      ACCELERATION: ACCELERATION.trim(trimSize: (ACCELERATION.count - min), trimStrategy: trimStrategy),
      ROTATION: ROTATION.trim(trimSize: (ROTATION.count - min), trimStrategy: trimStrategy),
      GRAVITY: GRAVITY.trim(trimSize: (GRAVITY.count - min), trimStrategy: trimStrategy),
      ALTITUDE: ALTITUDE // altitude does not trim
    )
  }
}

struct ReplaySensorDataV5: Codable {
  let sensorTimestamp: Int
  let systemTimestamp: Int
  let values: [Double]
  let sensorAccuracy: Double
}



extension ReplayDataV5 {
  func asMotionSensorData() -> [MotionSensorData]? {
    var result = [MotionSensorData]()

    if ACCELERATION.count == ROTATION.count &&
         ACCELERATION.count == GRAVITY.count {
      for index in ACCELERATION.indices {
        result.append(
          MotionSensorData(
            timestampSensor: ROTATION[index].sensorTimestamp,
            timestampLocal: ROTATION[index].systemTimestamp,
            accelerationData: ACCELERATION[index].values,
            gravityData: GRAVITY[index].values,
            rotationData:ROTATION[index].values,
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

  func asAltitudeSensorData() -> [AltitudeSensorData]? {
    var result = [AltitudeSensorData]()

    for index in ALTITUDE.indices {
      result.append(
        AltitudeSensorData(
          timestampSensor: ALTITUDE[index].sensorTimestamp,
          timestampLocal: ALTITUDE[index].systemTimestamp,
          altitudenData: ALTITUDE[index].values
        )
      )
    }
    return result
  }
}
