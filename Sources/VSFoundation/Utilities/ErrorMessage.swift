// ErrorMessage.swift
// VSFoundation

// Created by: CJ on 2021-11-26
// Copyright (c) 2021 Virtual Stores

import Foundation

public class ErrorMessage {

  public init() {}

  static public func methodOverride(fileName: String, methodName: String) -> String {
    return "You have to override method: \((fileName as NSString).lastPathComponent):\(methodName)"
  }

  static public func functionName(fileName: String, methodName: String) -> String {
    return "\((fileName as NSString).lastPathComponent):\(methodName)"
  }
}
