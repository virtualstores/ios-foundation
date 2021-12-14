// Debug.swift
// VSFoundation

// Created by: CJ on 2021-11-26
// Copyright (c) 2021 Virtual Stores

import Foundation

class Debug {
  static func log(message: String, withTag: String) {
    // todo check if running in debug mode, no debug logs should print in release mode
    print("\(withTag) -> \(message)")
  }

  static func createTag(fileName: String, functionName: String) -> String {
    return "\((fileName as NSString).lastPathComponent):\(functionName)"
  }
}