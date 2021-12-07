// ReplaySensorDataLoader.swift
// VSFoundation

// Created by: CJ on 2021-12-07
// Copyright (c) 2021 Virtual Stores

import Foundation

final class ReplaySensorDataLoader: IReplaySensorDataLoader {
  func loadFileFrom(path: String, inDirectory: FileManager.SearchPathDirectory) -> [MotionSensorData]? {
    let DocumentDirURL = try! FileManager.default.url(for: inDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

    let fileURL = DocumentDirURL.appendingPathComponent(path).appendingPathExtension("json")
    print("FilePath: \(fileURL.path)")

    let decoder = JSONDecoder()
    var readString = ""
    do {
      readString = try String(contentsOf: fileURL)
      let replayData = try decoder.decode(ReplaySensorData.self, from: Data(readString.utf8))
      var result = [MotionSensorData]()

      if replayData.replayData.ACCELERATION.count == replayData.replayData.ROTATION.count &&
          replayData.replayData.ACCELERATION.count == replayData.replayData.GRAVITY.count {
        for i in replayData.replayData.ACCELERATION.indices {
          result.append(
            MotionSensorData(
              timestampSensor: replayData.replayData.ACCELERATION[i].sensorTimestamp,
              timestampLocal: replayData.replayData.ACCELERATION[i].systemTimestamp,
              accelerationData:  replayData.replayData.ACCELERATION[i].values,
              gravityData: replayData.replayData.GRAVITY[i].values,
              rotationData: replayData.replayData.ROTATION[i].values
            )
          )
        }
      }
      return result
    } catch let error as NSError {
      print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
      return nil
    }
  }
}
