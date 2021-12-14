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
    func log(message: String)
}

public struct Logger: Loggable {
    public var verbosity: Verbosity
    
    public init(verbosity: Verbosity = .silent) {
        self.verbosity = verbosity
    }
    
    public func log(message: String) {
        switch verbosity {
        case .debug:
            print("DEBUG: \(message)")
        case .info:
            print("INFO: \(message)")
        case .notice:
            print("NOTICE: \(message)")
        case .warning:
            print("WARNING: \(message)")
        case .error:
            print("ERROR: \(message)")
        case .critical:
            print("CRITIAL: \(message)")
        case .alert:
            print("ALERT: \(message)")
        case .emergency:
            print("EMERGENCY: \(message)")
        case .silent:
            // no message
            break
        }
    }
}   
