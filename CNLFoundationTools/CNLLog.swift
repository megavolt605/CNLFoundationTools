//
//  CNLLog.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

/// Level of logging
/// - debug: Debug level
/// - network: Network level
/// - info: Information level
/// - warning: Warning level
/// - error: Error level
/// - nolog: Disable logging
public enum CNLLogLevel: Int {
    /// Debug level
    case debug
    /// Network level
    case network
    /// Information level
    case info
    /// Warning level
    case warning
    /// Error level
    case error
    /// Disable logging
    case nolog
    
    /// Array of all possible value
    static let allValues: [CNLLogLevel] = [debug, network, info, warning, error, nolog]
    
    /// Icon string
    var icon: String {
        switch self {
        case .debug: return "➡️"
        case .network: return "🌐"
        case .info: return "💡"
        case .warning: return "❗"
        case .error: return "❌"
        case .nolog: return ""
        }
    }
}

/// Log message to console with specified level
///
/// - Parameters:
///   - message: Message to log
///   - level: Log level
public func CNLLog(_ message: CustomStringConvertible, level: CNLLogLevel) {
    CNLLogger.log(message, level: level)
}

/// Log messages to console with specified level
///
/// - Parameters:
///   - messages: Array of messages to log
///   - level: Log level
///   - separator: Optional separator string
public func CNLLog(_ messages: [CustomStringConvertible], level: CNLLogLevel, separator: String? = nil) {
    CNLLogger.log(messages, level: level)
}

/// Pretty logger to the debug console
public struct CNLLogger {
    
    static var level: CNLLogLevel = .debug
    
    /// Log message to console with specified level
    ///
    /// - Parameters:
    ///   - message: Message to log
    ///   - level: Log level
    static func log(_ message: CustomStringConvertible, level: CNLLogLevel) {
        if CNLLogger.level.rawValue <= level.rawValue && level != .nolog {
            print("\(level.icon) \(message)")
        }
    }
    
    /// Log messages to console with specified level
    ///
    /// - Parameters:
    ///   - messages: Array of messages to log
    ///   - level: Log level
    ///   - separator: Optional separator string
    static func log(_ messages: [CustomStringConvertible], level: CNLLogLevel, separator: String? = nil) {
        if CNLLogger.level.rawValue <= level.rawValue && level != .nolog {
            let combinedMessage = messages.map { return $0.description }.joined(separator: separator ?? "")
            print("\(level.icon) \(combinedMessage)")
        }
    }
    
}
