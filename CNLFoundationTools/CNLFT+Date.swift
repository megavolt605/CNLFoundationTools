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
    
    public var isToday: Bool {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.isDateInToday(self)
    }
    
    public var isYesterday: Bool {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.isDateInYesterday(self)
    }
    
    public var isTomorrow: Bool {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.isDateInTomorrow(self)
    }
    
    public var daysAgo: Int {
        return daysEarlier(than: Date())
    }
    
    public func daysEarlier(than date: Date) -> Int {
        return abs(min(days(from: date), 0))
    }
    
    public func earlierDate(_ date: Date) -> Date {
        return (self.timeIntervalSince1970 <= date.timeIntervalSince1970) ? self : date
    }
    
    public func days(from date: Date, calendar: Calendar? = nil) -> Int {
        var calendarCopy = calendar
        if calendar == nil {
            calendarCopy = Calendar.autoupdatingCurrent
        }
        
        let earliest = earlierDate(date)
        let latest = (earliest == self) ? date : self
        let multiplier = (earliest == self) ? -1 : 1
        let components = calendarCopy!.dateComponents([.day], from: earliest, to: latest)
        return multiplier*components.day!
    }
    
    public var weekday: Int {
        return component(.weekday)
    }
    
    public func component(_ component: Calendar.Component) -> Int {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.component(component, from: self)
    }
    
    public func relative(to date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.doesRelativeDateFormatting = true
        if isToday {
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .none
        } else if isYesterday {
            dateFormatter.timeStyle = .none
            dateFormatter.dateStyle = .medium
        } else if daysAgo < 6 {
            return dateFormatter.weekdaySymbols[weekday - 1]
        } else {
            dateFormatter.timeStyle = .none
            dateFormatter.dateStyle = .short
        }
        return dateFormatter.string(from: self)
    }
    
}

/// Additional date comparision operators
public func >= (left: Date, right: Date) -> Bool {
    return !(left < right)
}
public func <= (left: Date, right: Date) -> Bool {
    return !(left > right)
}
