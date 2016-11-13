//
//  CNLFT+Date.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

public extension Date {
    
    /// Convert date from UTC
    public var fromUTC: Date {
        let calendar: Calendar = Calendar.current
        return addingTimeInterval(TimeInterval(calendar.timeZone.secondsFromGMT()))
    }
    
    /// Convert date to UTC
    public var toUTC: Date {
        let calendar: Calendar = Calendar.current
        return addingTimeInterval(-TimeInterval(calendar.timeZone.secondsFromGMT()))
    }
    
    /// Convert date to string with format specified
    ///
    /// - Parameter format: Format string
    /// - Returns: String with date conforming specified format
    public func toStringWithFormat(format: String) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = format
        return fmt.string(from: self)
    }
    
    /// String with ISO date
    public var ISODate: String {
        let f = DateFormatter()
        f.timeZone = TimeZone(abbreviation: "UTC")
        f.dateFormat = "yyyy-MM-dd"
        return f.string(from: self)
    }
    
    /// Stirng with ISO time
    public var ISOTime: String {
        let f = DateFormatter()
        f.timeZone = TimeZone(abbreviation: "UTC")
        f.dateFormat = "HH:mm:ss.SSSSSS"
        return f.string(from: self)
    }
    
    /// String with ISO date and time
    public var ISODateTime: String {
        let f = DateFormatter()
        f.timeZone = TimeZone(abbreviation: "UTC")
        f.dateFormat = "yyyy:MM:dd HH:mm:ss"
        return f.string(from: self)
    }
    
}

/// Date comparision operators

public func > (left: Date, right: Date) -> Bool {
    return left.compare(right) == ComparisonResult.orderedDescending
}

public func >= (left: Date, right: Date) -> Bool {
    let comparisonResult = left.compare(right)
    return comparisonResult == ComparisonResult.orderedDescending ||
        comparisonResult == ComparisonResult.orderedSame
}

public func < (left: Date, right: Date) -> Bool {
    return left.compare(right) == ComparisonResult.orderedAscending
}

public func <= (left: Date, right: Date) -> Bool {
    let comparisonResult = left.compare(right)
    return comparisonResult == ComparisonResult.orderedAscending ||
        comparisonResult == ComparisonResult.orderedSame
}
