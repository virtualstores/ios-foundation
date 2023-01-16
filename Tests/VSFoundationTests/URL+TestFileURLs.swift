// URL+TestFileURLs.swift
// 

// Created by: CJ on 2022-01-06
// Copyright (c) 2022 Virtual Stores

import Foundation

extension URL {

  enum ReplayDataLoaderTests {
    static let replayDataV2 = Bundle.module.url(forResource: "ReplayDataTests/replayDataV2Test", withExtension: "json")
    static let replayDataV3andV4 = Bundle.module.url(forResource: "ReplayDataTests/replayDataV4Test", withExtension: "json")
    static let replayDataV5 = Bundle.module.url(forResource: "ReplayDataTests/raplayDataV5Test", withExtension: "json")
  }


}
