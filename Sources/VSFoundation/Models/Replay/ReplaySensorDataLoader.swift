// ReplaySensorDataLoader.swift
// VSFoundation

// Created by: CJ on 2021-12-07
// Copyright (c) 2021 Virtual Stores

import Foundation
import TabularData

public final class ReplaySensorDataLoader: IReplaySensorDataLoader {

  public init() {}

  public func decodeFileFrom(url: URL) -> [MotionSensorData]? {
    // we found the file in our bundle!
    if let fileContents = try? String(contentsOf: url) {
      // we loaded the file into a string!
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

  public func loadFileFrom(path: String, withExtension: String, inDirectory: FileManager.SearchPathDirectory) -> [MotionSensorData]? {
    let DocumentDirURL = try! FileManager.default.url(for: inDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

    let fileURL = DocumentDirURL.appendingPathComponent(path).appendingPathExtension(withExtension)

    do {
      return try decodeReplayData(data: Data(String(contentsOf: fileURL).utf8))
    } catch let error as NSError {
      Logger(verbosity: .error)
        .log(
          tag: "ReplaySensorDataLoader.loadFileFromBundle",
          message: "Failed decoding file: \(path + "." + withExtension), Error: " + error.localizedDescription
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
      for i in replayData.replayData.ACCELERATION.indices {
        result.append(
          MotionSensorData(
            timestampSensor: replayData.replayData.ACCELERATION[i].sensorTimestamp,
            timestampLocal: replayData.replayData.ACCELERATION[i].systemTimestamp,
            accelerationData: replayData.replayData.ACCELERATION[i].values.map { $0.asDouble },
            gravityData: replayData.replayData.GRAVITY[i].values.map { $0.asDouble },
            rotationData: replayData.replayData.ROTATION[i].values.map { $0.asDouble }
          )
        )
      }
    }
    return result
  }
}


