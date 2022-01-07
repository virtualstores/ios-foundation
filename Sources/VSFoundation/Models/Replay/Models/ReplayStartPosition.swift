// ReplayStartPosition.swift
// VSFoundation

// Created by: CJ on 2022-01-07
// Copyright (c) 2021 Virtual Stores

import Foundation

public struct ReplayStartPosition: Codable {
  public let timestamp: Int
  public let position: StartPosition
  public let angle: Double
}

public struct StartPosition: Codable {
  public let x: Double
  public let y: Double
}
