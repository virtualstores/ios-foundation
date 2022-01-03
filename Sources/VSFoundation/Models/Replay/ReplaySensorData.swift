// ReplaySensorData.swift
// VSFoundation

// Created by: CJ on 2021-12-07
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
  let second: [Float]
}

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
  let values: [Float]
}


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
  let values: [Float]
  let sensorAccuracy: Int
}
