// ReplaySensorData.swift
// VSFoundation

// Created by: CJ on 2021-12-07
// Copyright (c) 2021 Virtual Stores

import Foundation

struct ReplaySensorData: Codable {
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
  let values: [Float]
  let sensorAccuracy: Int
}
