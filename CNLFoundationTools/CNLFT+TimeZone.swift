//
//  CNLFT+TimeZone.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

public extension TimeZone {
    
    /// - Returns: String with timezone of the date (ex: +0300, -0200, etc.)
    public static var localTimeZoneString: String {
        let seconds = NSTimeZone.local.secondsFromGMT()
        let minutes = abs(((seconds as Int) / 60) % 60)
        var minutesString = "\(minutes)"
        if minutes < 10 {
            minutesString = "0" + minutesString
        }
        let hours = abs(((seconds as Int) / 3600) % 24)
        var hoursString = "\(hours)"
        if hours < 10 {
            hoursString = "0" + hoursString
        }
        if seconds >= 0 {
            return "+\(hoursString)\(minutesString)"
        } else  {
            return "-\(hoursString)\(minutesString)"
        }
    }
}
