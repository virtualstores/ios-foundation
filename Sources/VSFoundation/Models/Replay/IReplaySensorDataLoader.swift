// IReplaySensorDataLoader.swift
// VSFoundation

// Created by: CJ on 2021-12-07
// Copyright (c) 2021 Virtual Stores

import Foundation

public protocol IReplaySensorDataLoader {
  func decodeFileFrom(url: URL) -> [MotionSensorData]?
}
