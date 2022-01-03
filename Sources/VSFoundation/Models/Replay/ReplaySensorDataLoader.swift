// ReplaySensorDataLoader.swift
// VSFoundation

// Created by: CJ on 2021-12-07
// Copyright (c) 2021 Virtual Stores

import Foundation

public final class ReplaySensorDataLoader: IReplaySensorDataLoader {

  public init() {}

  public func decodeFileFrom(url: URL, fileVersion: ReplayFileVersion) -> [MotionSensorData]? {
    if let fileContents = try? String(contentsOf: url) {
      do {
        return try decodeReplayData(data: Data(fileContents.utf8), fileVersion: fileVersion)
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

  private func decodeReplayData(data: Data, fileVersion: ReplayFileVersion) throws -> [MotionSensorData]? {
    let decoder = JSONDecoder()
    var result: [MotionSensorData]?
    switch fileVersion {
    case .v2: result = try decoder.decode(ReplaySensorDataFileV2.self, from: data).asMotionSensorData()
    // ReplayDataV4 supports decoding ReplayDataV3
    case .v3: result = try decoder.decode(ReplaySensorDataFileV4.self, from: data).asMotionSensorData()
    case .v4: result = try decoder.decode(ReplaySensorDataFileV4.self, from: data).asMotionSensorData()
    case .v5: result = try decoder.decode(ReplaySensorDataFileV5.self, from: data).asMotionSensorData()
    }

    guard let result = result else {
      throw "File data corrupt, number of sensor values not equal for ACCELERATON, GRAVITY and ROTATION. Possible cause: Tried to load ReplayData file recorded on Android device"
    }

    return result
  }
}