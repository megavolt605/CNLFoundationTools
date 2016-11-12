//
//  CNLog.swift
//  CNFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

public enum CNLogLevel: Int {
    case debug, network, info, warning, error
    static let allValues: [CNLogLevel] = [debug, network, info, warning, error]
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

public func CNLog(_ message: String, level: CNLogLevel) {
    CNLogger.log(message, level: level)
}

public struct CNLogger {
    
    static var level: CNLogLevel = .debug
    
    static func log(_ message: String, level: CNLogLevel) {
        print("\(level.description) \(message)")
    }
    
}
