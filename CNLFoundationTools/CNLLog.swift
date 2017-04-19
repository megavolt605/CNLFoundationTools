//
//  CNLLog.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

public enum CNLLogLevel: Int {
    case debug, network, info, warning, error
    static let allValues: [CNLLogLevel] = [debug, network, info, warning, error]
    var description: String {
        switch self {
        case .debug: return "➡️"
        case .network: return "🌐"
        case .info: return "💡"
        case .warning: return "❗"
        case .error: return "❌"
        }
    }
}

public func CNLLog(_ message: CustomStringConvertible, level: CNLLogLevel) {
    CNLLogger.log(message, level: level)
}

public func CNLLog(_ message: [CustomStringConvertible], level: CNLLogLevel) {
    CNLLogger.log(message, level: level)
}

public struct CNLLogger {
    
    static var level: CNLLogLevel = .debug
    
    static func log(_ message: CustomStringConvertible, level: CNLLogLevel) {
        print("\(level.description) \(message)")
    }
    
    static func log(_ message: [CustomStringConvertible], level: CNLLogLevel) {
        let combinedMessage = message.map { return $0.description }.joined()
        print("\(level.description) \(combinedMessage)")
    }
    
}
