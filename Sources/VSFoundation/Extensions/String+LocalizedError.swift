// String+LocalizedError.swift
// VSFoundation
//
// Created by CJ on 2021-12-14
// Copyright Virtual Stores - 2021
//

import Foundation

extension String: LocalizedError {
  public var errorDescription: String? { self }
}
