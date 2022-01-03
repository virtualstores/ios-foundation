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
        switch fileVersion {
        case .v2: return try decodeReplayDataV2(data: Data(fileContents.utf8))
        case .v3: return try decodeReplayDataV4(data: Data(fileContents.utf8))
        case .v4: return try decodeReplayDataV4(data: Data(fileContents.utf8))
        case .v5: return try decodeReplayDataV5(data: Data(fileContents.utf8))
        }
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

  private func decodeReplayDataV2(data: Data) throws -> [MotionSensorData]? {
    let decoder = JSONDecoder()

    let replayData = try decoder.decode(ReplaySensorDataFileV2.self, from: data)

    var result = [MotionSensorData]()
    if replayData.sensorData.ACCELERATION.count == replayData.sensorData.ROTATION.count &&
         replayData.sensorData.ACCELERATION.count == replayData.sensorData.GRAVITY.count {
      for index in replayData.sensorData.ACCELERATION.indices {
        result.append(
          MotionSensorData(
            timestampSensor: replayData.sensorData.ACCELERATION[index].first,
            timestampLocal: 0,
            accelerationData: replayData.sensorData.ACCELERATION[index].second,
            gravityData: replayData.sensorData.GRAVITY[index].second,
            rotationData: replayData.sensorData.ROTATION[index].second
          )
        )
      }
    }
    return result
  }

  private func decodeReplayDataV4(data: Data) throws -> [MotionSensorData]? {
    let decoder = JSONDecoder()

    let replayData = try decoder.decode(ReplaySensorDataFileV4.self, from: data)

    var result = [MotionSensorData]()
    if replayData.replayData.ACCELERATION.count == replayData.replayData.ROTATION.count &&
         replayData.replayData.ACCELERATION.count == replayData.replayData.GRAVITY.count {
      for index in replayData.replayData.ACCELERATION.indices {
        result.append(
          MotionSensorData(
            timestampSensor: replayData.replayData.ACCELERATION[index].sensorTimestamp,
            timestampLocal: replayData.replayData.ACCELERATION[index].systemTimestamp,
            accelerationData: replayData.replayData.ACCELERATION[index].values,
            gravityData: replayData.replayData.GRAVITY[index].values,
            rotationData: replayData.replayData.ROTATION[index].values
          )
        )
      }
    }
    return result
  }

  private func decodeReplayDataV5(data: Data) throws -> [MotionSensorData]? {
    let decoder = JSONDecoder()

    let replayData = try decoder.decode(ReplaySensorDataFileV5.self, from: data)

    var result = [MotionSensorData]()
    if replayData.replayData.ACCELERATION.count == replayData.replayData.ROTATION.count &&
         replayData.replayData.ACCELERATION.count == replayData.replayData.GRAVITY.count {
      for index in replayData.replayData.ACCELERATION.indices {
        result.append(
          MotionSensorData(
            timestampSensor: replayData.replayData.ACCELERATION[index].sensorTimestamp,
            timestampLocal: replayData.replayData.ACCELERATION[index].systemTimestamp,
            accelerationData: replayData.replayData.ACCELERATION[index].values,
            gravityData: replayData.replayData.GRAVITY[index].values,
            rotationData: replayData.replayData.ROTATION[index].values
          )
        )
      }
    }
    return result
  }
}
