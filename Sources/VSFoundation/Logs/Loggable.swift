//
// Loggable.swift
// VSFoundation
//
// Created by Gabriel Sabadin on 2021-12-13.
// Copyright Virtual Stores - 2021
//

import Foundation

public enum Verbosity {
    case debug
    case info
    case notice
    case warning
    case error
    case critical
    case alert
    case emergency
    case silent
}

public protocol Loggable {
    var verbosity: Verbosity { get set }
    func log(tag: String, message: String)
}

public struct Logger: Loggable {
    public var verbosity: Verbosity

    public init(verbosity: Verbosity = .silent) {
        self.verbosity = verbosity
    }

    public func log(tag: String, message: String) {
        switch verbosity {
        case .debug:
            print("DEBUG: \(tag): \(message)")
        case .info:
            print("INFO: \(tag): \(message)")
        case .notice:
            print("NOTICE: \(tag): \(message)")
        case .warning:
            print("WARNING: \(tag): \(message)")
        case .error:
            print("ERROR: \(tag): \(message)")
        case .critical:
            print("CRITIAL: \(tag): \(message)")
        case .alert:
            print("ALERT: \(tag): \(message)")
        case .emergency:
            print("EMERGENCY: \(tag): \(message)")
        case .silent:
            // no message
            break
        }
    }
}
