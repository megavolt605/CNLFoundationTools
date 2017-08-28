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
    public static let allValues: [CNLLogLevel] = [debug, network, info, warning, error, nolog]
    
    /// Icon string
    public var icon: String {
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

/// Pretty logger to the debug console
public struct CNLLogger {
    
    public static var prefix: String = "CNL"

    public struct Message {
        public var code: String
        public var message: String
        
        public init(code: String, message: String) {
            self.code = code
            self.message = message
        }
        
        fileprivate func formatLogMessage(kind: String? = nil, _ params: CVarArg ...) -> String {
            let formattedMessage = String(format: self.message, params)
            if let kind = kind {
                return "[\(CNLLogger.prefix)] \(kind) [\(code)] \(formattedMessage)"
            } else {
                return "[\(CNLLogger.prefix)] [\(code)] \(formattedMessage)"
            }
        }
        
        fileprivate func formatLogMessage(kind: String? = nil) -> String {
            if let kind = kind {
                return "[\(CNLLogger.prefix)] \(kind) [\(code)] \(message)"
            } else {
                return "[\(CNLLogger.prefix)] [\(code)] \(message)"
            }
        }
    }
    
    public static var level: CNLLogLevel = .debug
    
    /// Log message to console with specified level
    ///
    /// - Parameters:
    ///   - message: Message to log
    ///   - level: Log level
    public static func log(_ message: CustomStringConvertible, level: CNLLogLevel) {
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
    public static func log(_ messages: [CustomStringConvertible], level: CNLLogLevel, separator: String? = nil) {
        if CNLLogger.level.rawValue <= level.rawValue && level != .nolog {
            let combinedMessage = messages.map { return $0.description }.joined(separator: separator ?? "")
            print("\(level.icon) \(combinedMessage)")
        }
    }
    
}

public func cnlLog(_ code: CNLLogger.Message, _ level: CNLLogLevel = .debug, _ params: CVarArg ...) {
    CNLLogger.log(code.formatLogMessage(params), level: level)
}

public func cnlLog(_ code: CNLLogger.Message, _ level: CNLLogLevel = .debug) {
    CNLLogger.log(code.formatLogMessage(), level: level)
}

public func cnlFatalError(_ code: CNLLogger.Message, _ params: CVarArg ...) -> Never  {
    fatalError(code.formatLogMessage(kind: "[FATAL ERROR]", params))
}

public func cnlFatalError(_ code: CNLLogger.Message) -> Never  {
    fatalError(code.formatLogMessage(kind: "[FATAL ERROR]"))
}

public func assert(_ condition: Bool, _ code: CNLLogger.Message, _ params: CVarArg ...) {
    assert(condition, code.formatLogMessage(kind: "[ASSERT]", params))
}

public func assert(_ condition: Bool, _ code: CNLLogger.Message) {
    assert(condition, code.formatLogMessage(kind: "[ASSERT]"))
}
