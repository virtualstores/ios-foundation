//
// Loggable.swift
// VSFoundation
//
// Created by Gabriel Sabadin on 2021-12-13.
// Copyright Virtual Stores - 2021
//

import Foundation

/**
 Verbosity Desired level to determine the output of the logger
 ````
 case debug
 case info
 case warning
 case error
 case critical
 case silent
 ````
*/

public enum Verbosity {
    /// used for debug purposes
    case debug
    
    /// used to add relevant information
    case info
    
    /// used to indicate warnings and provide guidance
    case warning
    
    /// used to indicate errors and provide ways to troubleshoot
    case error
    
    /// used to indicate critical errors
    case critical
    
    /// used to silent the logger (nothing will be printed out)
    case silent
}

public protocol Loggable {
    /// @abstract The desired verbosity
    static var verbosity: Verbosity? { get set }
    
    /// Method that triggers the logging procedure
    /// - Author: Gabriel Sabadin
    ///
    /// - Parameter tag: A String to determine a tag for the logging (in case you want to create a classifier)
    /// - Parameter message: A String to determine the message you want to be logged
    static func log(tag: String, message: String)
}

public struct Logger: Loggable {
    public static var verbosity: Verbosity?
    public static func setVerbosityLevel(with newValue: Verbosity?) {
        verbosity = newValue
    }

    public static var level: Verbosity {
        guard let verbosity = verbosity else {
            return Verbosity.silent
        }

        return verbosity
    }

    public static func log(tag: String = "", message: String) {
        guard let verbosity = verbosity else { return }
        
        switch verbosity {
        case .debug:
            print("🕵️‍♀️ DEBUG: \(tag): \(message)")
        case .info:
            print("ℹ️ INFO: \(tag): \(message)")
        case .warning:
            print("⚠️ WARNING: \(tag): \(message)")
        case .error:
            print("⛔️ ERROR: \(tag): \(message)")
        case .critical:
            print("☣️ CRITICAL: \(tag): \(message)")
        case .silent:
            // no log message message
            break
        }
    }
}
