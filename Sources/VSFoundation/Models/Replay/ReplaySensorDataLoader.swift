// ReplaySensorDataLoader.swift
// VSFoundation

// Created by: CJ on 2021-12-07
// Copyright (c) 2021 Virtual Stores

import Foundation

public final class ReplaySensorDataLoader: IReplaySensorDataLoader {

  public init() {}

  public func decodeFileFrom(url: URL, fileVersion: ReplayFileVersion, trimStrategy: TrimStrategy = .end) -> ReplayData? {
    if let fileContents = try? String(contentsOf: url) {
      do {
        return try decodeReplayData(data: Data(fileContents.utf8), fileVersion: fileVersion, trimStrategy: trimStrategy)
      } catch let error as NSError {
        Logger(verbosity: .error)
          .log(
            tag: "ReplaySensorDataLoader.loadFileFromBundle",
            message: "Failed decoding file: \(url), Error: " + error.localizedDescription
          )
        return nil
      }

    } else {
      Logger(verbosity: .error)
        .log(
          tag: "ReplaySensorDataLoader.loadFileFromBundle",
          message: "Could not read file content for file: \(url)"
        )
      return nil
    }
  }

  private func decodeReplayData(data: Data, fileVersion: ReplayFileVersion, trimStrategy: TrimStrategy) throws -> ReplayData {
    let decoder = JSONDecoder()
    var sensorData: [MotionSensorData]?
    var startPosition: ReplayStartPosition?
    switch fileVersion {
    case .v2:
      let replayData = try decoder.decode(ReplaySensorDataFileV2.self, from: data)
      sensorData = replayData.sensorData.trim(trimStrategy: trimStrategy).asMotionSensorData()
      startPosition = replayData.startPosition
      // ReplayDataV4 supports decoding ReplayDataV3
    case .v3:
      let replayData = try decoder.decode(ReplaySensorDataFileV4.self, from: data)
      sensorData = replayData.sensorData.trim(trimStrategy: trimStrategy).asMotionSensorData()
      startPosition = replayData.startPosition
    case .v4:
      let replayData = try decoder.decode(ReplaySensorDataFileV4.self, from: data)
      sensorData = replayData.sensorData.trim(trimStrategy: trimStrategy).asMotionSensorData()
      startPosition = replayData.startPosition
    case .v5:
      let replayData = try decoder.decode(ReplaySensorDataFileV5.self, from: data)
      sensorData = replayData.replayData.trim(trimStrategy: trimStrategy).asMotionSensorData()
      startPosition = replayData.startPosition
    }

    guard let sensorData = sensorData, let startPosition = startPosition else {
      throw "File data corrupt, FileVersion: \(fileVersion), number of sensor values not equal for ACCELERATON, GRAVITY and ROTATION. Possible cause: Tried to load ReplayData file recorded on Android device"
    }
    let result = ReplayData(
      sensorData: sensorData,
      startPosition: startPosition)

    return result
  }
}
