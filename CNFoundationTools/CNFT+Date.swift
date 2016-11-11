//
//  CNFT+Date.swift
//  CNFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

public extension Date {
    
    public var fromUTC: Date {
        let calendar: Calendar = Calendar.current
        return addingTimeInterval(TimeInterval(calendar.timeZone.secondsFromGMT()))
    }
    
    public var toUTC: Date {
        let calendar: Calendar = Calendar.current
        return addingTimeInterval(-TimeInterval(calendar.timeZone.secondsFromGMT()))
    }
    
    public func toStringWithFormat(format: String) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = format;
        return fmt.string(from: self)
    }
    
    public var ISODate: String {
        let f = DateFormatter()
        f.timeZone = TimeZone(abbreviation: "UTC")
        f.dateFormat = "yyyy-MM-dd"
        return f.string(from: self)
    }
    
    public var ISOTime: String {
        let f = DateFormatter()
        f.timeZone = TimeZone(abbreviation: "UTC")
        f.dateFormat = "HH:mm:ss.SSSSSS"
        return f.string(from: self)
    }
    
    public var ISODateTime: String {
        let f = DateFormatter()
        f.timeZone = TimeZone(abbreviation: "UTC")
        f.dateFormat = "yyyy:MM:dd HH:mm:ss"
        return f.string(from: self)
    }
    
}

// operators

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
