// IReplaySensorDataLoader.swift
// VSFoundation

// Created by: CJ on 2021-12-07
// Copyright (c) 2021 Virtual Stores

import Foundation

public protocol IReplaySensorDataLoader {
  func decodeFileFrom(url: URL, fileVersion: ReplayFileVersion) -> [MotionSensorData]?
}

public enum ReplayFileVersion {
  case v2
  case v3
  case v4
  case v5
}
