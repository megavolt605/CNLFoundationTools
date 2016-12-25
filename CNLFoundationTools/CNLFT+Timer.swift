//
//  CNLFT+Timer.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

public extension Timer {
    
    /// Creates disposable timer and schedule it to invoke handler after delay
    ///
    /// - Parameters:
    ///   - delay: Delay (seconds)
    ///   - handler: Closure to be invoked
    /// - Returns: Timer instance
    public class func schedule(delay: TimeInterval, handler: @escaping (Timer?) -> Void) -> Timer? {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer
    }
    
    /// Creates timer and schedule it to invoke handler after delay, repeating with specified interval
    ///
    /// - Parameters:
    ///   - interval: Repeating interval
    ///   - handler: Closure to be invoked
    /// - Returns: Timer instance
    public class func schedule(delay: TimeInterval = 0.0, repeatInterval interval: TimeInterval, handler: @escaping (Timer?) -> Void) -> Timer? {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer
    }
}
