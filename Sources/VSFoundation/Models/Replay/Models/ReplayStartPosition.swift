// ReplayStartPosition.swift
// VSFoundation

// Created by: CJ on 2022-01-07
// Copyright (c) 2021 Virtual Stores

import Foundation

public struct ReplayStartPosition: Codable {
  let timestamp: Int
  let position: StartPosition
  let angle: Double
}

public struct StartPosition: Codable {
  let x: Double
  let y: Double
}
