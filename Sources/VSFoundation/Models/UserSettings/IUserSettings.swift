// ReplayDataV2.swift
// VSFoundation

// Created by: CJ on 2022-01-04
// Copyright (c) 2021 Virtual Stores
import Foundation

public protocol IUserSettings {
  var userHeight: Double? { get }
  var speedRegressionSlope: Double? { get }
  var speedRegressionIntercept: Double? { get }
}
