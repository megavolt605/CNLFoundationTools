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
    
    /// Checks for date is in today
    public var isToday: Bool {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.isDateInToday(self)
    }
    
    /// Checks for date is in yesterday
    public var isYesterday: Bool {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.isDateInYesterday(self)
    }
    
    /// Checks for date is in tomorrow
    public var isTomorrow: Bool {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.isDateInTomorrow(self)
    }
    
    /// Return number of days since now
    public var daysAgo: Int {
        return daysEarlier(than: Date())
    }
    
    /// Number of days when self is earlier than argument
    ///
    /// - Parameter date: Source date
    /// - Returns: Number of days, or 0 in case self is later than parameter
    public func daysEarlier(than date: Date) -> Int {
        return abs(min(days(from: date), 0))
    }
    
    /// Returns most earlier date form self and parameter
    ///
    /// - Parameter date: Source date
    /// - Returns: Most earlier date
    public func earlierDate(_ date: Date) -> Date {
        return (self.timeIntervalSince1970 <= date.timeIntervalSince1970) ? self : date
    }
    
    /// Days between self and parameter using custom calendar
    ///
    /// - Parameters:
    ///   - date: Source date
    ///   - calendar: Calendar instance (will used Calendar.autoupdatingCurrent when not specified)
    /// - Returns: <#return value description#>
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
    
    /// Weekday of the date
    public var weekday: Int {
        return component(.weekday)
    }
    
    /// Extract calendar component from the date
    ///
    /// - Parameter component: Component to extract
    /// - Returns: Result value
    public func component(_ component: Calendar.Component) -> Int {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.component(component, from: self)
    }
    
    /// Returns string with relative date information from now (today, yesterday, 2..6 days ago or date in short format)
    ///
    /// - Parameter date: Date to compare with
    /// - Returns: Result string
    public func relative() -> String {
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

/// Additional date comparision operators (greater or equal)
public func >= (left: Date, right: Date) -> Bool {
    return !(left < right)
}
/// Additional date comparision operators (lesser or equal)
public func <= (left: Date, right: Date) -> Bool {
    return !(left > right)
}
