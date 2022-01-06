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
      XCTAssertNotNil(loadReplayDataFrom(url: v2Url, fileVersion: .v2))
      XCTAssertNotNil(loadReplayDataFrom(url: v3_v4Url, fileVersion: .v3))
      XCTAssertNotNil(loadReplayDataFrom(url: v3_v4Url, fileVersion: .v4))
      XCTAssertNotNil(loadReplayDataFrom(url: v5Url, fileVersion: .v5))
    } else {
      XCTAssertTrue(false)
    }
  }

  private func loadReplayDataFrom(url: URL, fileVersion: ReplayFileVersion) -> [MotionSensorData]? {
    return ReplaySensorDataLoader().decodeFileFrom(url: url, fileVersion: fileVersion)
  }
}
