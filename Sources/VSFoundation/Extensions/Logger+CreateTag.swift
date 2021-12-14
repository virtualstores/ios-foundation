// Logger+CreateTag.swift
// VSFoundation
//
// Created by CJ on 2021-12-14
// Copyright Virtual Stores - 2021
//

import Foundation

public extension Logger {
  static func createTag(fileName: String, functionName: String) -> String {
    return "\((fileName as NSString).lastPathComponent):\(functionName)"
  }
}
