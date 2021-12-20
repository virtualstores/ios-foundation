// ReplaySensorDataLoader.swift
// VSFoundation

// Created by: CJ on 2021-12-07
// Copyright (c) 2021 Virtual Stores

import Foundation
import TabularData

public final class ReplaySensorDataLoader: IReplaySensorDataLoader {

  public init() {}

  public func decodeFileFrom(url: URL) -> [MotionSensorData]? {
    if let fileContents = try? String(contentsOf: url) {
      do {
        return try decodeReplayData(data: Data(fileContents.utf8))
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

  private func decodeReplayData(data: Data) throws -> [MotionSensorData]? {
    let decoder = JSONDecoder()

    let replayData = try decoder.decode(ReplaySensorData.self, from: data)

    var result = [MotionSensorData]()
    if replayData.replayData.ACCELERATION.count == replayData.replayData.ROTATION.count &&
         replayData.replayData.ACCELERATION.count == replayData.replayData.GRAVITY.count {
      for index in replayData.replayData.ACCELERATION.indices {
        result.append(
          MotionSensorData(
            timestampSensor: replayData.replayData.ACCELERATION[index].sensorTimestamp,
            timestampLocal: replayData.replayData.ACCELERATION[index].systemTimestamp,
            accelerationData: replayData.replayData.ACCELERATION[index].values.map { $0.asDouble },
            gravityData: replayData.replayData.GRAVITY[index].values.map { $0.asDouble },
            rotationData: replayData.replayData.ROTATION[index].values.map { $0.asDouble }
          )
        )
      }
    }
    return result
  }
}
