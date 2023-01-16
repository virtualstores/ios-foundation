// ReplayDataLoaderTest.swift
// 

// Created by: CJ on 2022-01-06
// Copyright (c) 2022 Virtual Stores

import Foundation

import XCTest
@testable import VSFoundation

final class ReplayDataLoaderTest: XCTestCase {

  func test_loading_replay_files() throws {
    if let v2Url = URL.ReplayDataLoaderTests.replayDataV2,
        let v3_v4Url = URL.ReplayDataLoaderTests.replayDataV3andV4,
       let v5Url = URL.ReplayDataLoaderTests.replayDataV5 {

      let dataV2 = loadReplayDataFrom(url: v2Url, fileVersion: .v2)
      let dataV3 = loadReplayDataFrom(url: v3_v4Url, fileVersion: .v3)
      let dataV4 = loadReplayDataFrom(url: v3_v4Url, fileVersion: .v4)
      let dataV5 = loadReplayDataFrom(url: v5Url, fileVersion: .v5)

      XCTAssertNotNil(dataV2?.sensorData)
      XCTAssertNotNil(dataV2?.startPosition)
      XCTAssertNotNil(dataV3?.sensorData)
      XCTAssertNotNil(dataV3?.startPosition)
      XCTAssertNotNil(dataV4?.sensorData)
      XCTAssertNotNil(dataV4?.startPosition)
      XCTAssertNotNil(dataV5?.sensorData)
      XCTAssertNotNil(dataV5?.startPosition)
      XCTAssertNotNil(dataV5?.altitudeData)

    } else {
      XCTAssertTrue(false)
    }
  }

  private func loadReplayDataFrom(url: URL, fileVersion: ReplayFileVersion) -> ReplayData? {
    return ReplaySensorDataLoader().decodeFileFrom(url: url, fileVersion: fileVersion)
  }
}
