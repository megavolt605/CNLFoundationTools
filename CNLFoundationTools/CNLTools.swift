//
//  CNLTools.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

@inline(__always)
public func syncCritical(object: Any, _ closure: () -> Void) {
    objc_sync_enter(object)
    closure()
    objc_sync_exit(object)
}

/// Helper function
///
/// Typical usage:
/// with(UILabel()) {
///     $0.text = "text"
///     $0.font = someFont
///     self.addSubview($0)
/// }

/*
@discardableResult
public func with<T>(_ target: T?, doWith: (T) -> ()) -> T? {
    if let target = target {
        doWith(target)
    }
    return target
}

@discardableResult
public func with<T>(_ target: T, doWith: (T) -> ()) -> T {
    doWith(target)
    return target
}

@discardableResult
public func with<T, U>(_ target: T, doWith: (T) -> U) -> U {
    return doWith(target)
}
*/

precedencegroup CNFTWith {
    associativity: right
    higherThan: BitwiseShiftPrecedence
}

infix operator -->: CNFTWith

@inline(__always)
@discardableResult
public func --> <T, U>(left: T, right: (T) -> U) -> U {
    return right(left)
}

@inline(__always)
@discardableResult
public func --> <T, U>(left: T?, right: (T?) -> U?) -> U? {
    return right(left)
}

@inline(__always)
@discardableResult
public func --> <T>(left: T, right: (T) -> ()) -> T {
    right(left)
    return left
}

@inline(__always)
@discardableResult
public func --> <T>(left: T?, right: (T?) -> ()) -> T? {
    right(left)
    return left
}

