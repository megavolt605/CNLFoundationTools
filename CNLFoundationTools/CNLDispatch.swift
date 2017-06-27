//
//  CNLDispatch.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

/// Run backgoundClosure async in global queue, then completionClosure async in main queue
///
/// - Parameters:
///   - backgroundClosure: payload closure
///   - completionClosure: completion closure
public func asyncGlobal (_ backgroundClosure: @escaping () -> Void, _ completionClosure: @escaping (() -> Void) ) {
    DispatchQueue.global(qos: .default).async {
        backgroundClosure()
        DispatchQueue.main.async {
            completionClosure()
        }
    }
}

/// Run backgoundClosure async in global queue
///
/// - Parameters:
///   - backgroundClosure: payload closure
public func asyncGlobal (_ backgroundClosure: @escaping () -> Void) {
    DispatchQueue.global(qos: .default).async {
        backgroundClosure()
    }
}

/// Run backgoundClosure async in global queue, then calls completionClosure async in main queue with result of backgroundClosure
///
/// - Parameters:
///   - backgroundClosure: payload closure with result
///   - completionClosure: completion closure with parameter
public func asyncGlobal<R> (_ backgroundClosure: @escaping () -> R, _ completionClosure: @escaping ((_ result: R) -> Void) ) {
    DispatchQueue.global(qos: .default).async {
        let res = backgroundClosure()
        DispatchQueue.main.async {
            completionClosure(res)
        }
    }
}

/// Run backgoundClosure sync in main queue
///
/// - Parameter backgroundClosure: <#backgroundClosure description#>
public func syncMain (_ backgroundClosure: @escaping () -> Void ) {
    DispatchQueue.main.sync {
        backgroundClosure()
    }
}

/// Run backgoundClosure async in main queue, then calls completionClosure
///
/// - Parameters:
///   - backgroundClosure: payload closure
///   - completionClosure: completion closure
public func asyncMain (_ backgroundClosure: @escaping () -> Void, _ completionClosure: @escaping (() -> Void) ) {
    DispatchQueue.main.async {
        backgroundClosure()
        completionClosure()
    }
}

/// Run backgoundClosure async in main queue
///
/// - Parameters:
///   - backgroundClosure: payload closure
public func asyncMain (_ backgroundClosure: @escaping () -> Void ) {
    DispatchQueue.main.async {
        backgroundClosure()
    }
}

/// Run backgoundClosure async in main queue, then calls completionClosure with result of backgroundClosure
///
/// - Parameters:
///   - backgroundClosure: payload closure with result
///   - completionClosure: completion closure with parameter
public func asyncMain<R> (_ backgroundClosure: @escaping () -> R, _ completionClosure: @escaping ((_ result: R) -> Void) ) {
    DispatchQueue.main.async {
        let res = backgroundClosure()
        completionClosure(res)
    }
}

/// Brackets call of closure in objc_sync_enter and objc_sync_exit calls, assotiated with object
///
/// - Parameters:
///   - object: Object used as lock souorce
///   - closure: Closure to execute while lock is active
@inline(__always)
public func syncCritical(_ object: Any, _ closure: () -> Void) {
    objc_sync_enter(object)
    closure()
    objc_sync_exit(object)
}

precedencegroup CNFTWith {
    associativity: right
    higherThan: BitwiseShiftPrecedence
}

infix operator -->: CNFTWith

/// Executes right part with left part as an argument, returns retult of execution (not Optional)
///
/// - Parameters:
///   - left: Source value
///   - right: Closue to execute
/// - Returns: Result of left closure
@inline(__always)
@discardableResult
public func --> <T, U>(left: T, right: (T) -> U) -> U {
    return right(left)
}

/// Executes right part with left part as an argument, returns retult of execution (Optional)
///
/// - Parameters:
///   - left: Source value
///   - right: Closue to execute
/// - Returns: Result of left closure
@inline(__always)
@discardableResult
public func --> <T, U>(left: T?, right: (T?) -> U?) -> U? {
    return right(left)
}

/// Executes right part with left part as an argument, returns left part (not Optional)
///
/// - Parameters:
///   - left: Source value
///   - right: Closue to execute
/// - Returns: Result of left closure
@inline(__always)
@discardableResult
public func --> <T>(left: T, right: (T) -> Void) -> T {
    right(left)
    return left
}

/// Executes right part with left part as an argument, returns left part (Optional)
///
/// - Parameters:
///   - left: Source value
///   - right: Closue to execute
/// - Returns: Result of left closure
@inline(__always)
@discardableResult
public func --> <T>(left: T?, right: (T?) -> Void) -> T? {
    right(left)
    return left
}
