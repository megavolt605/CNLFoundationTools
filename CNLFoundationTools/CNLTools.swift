//
//  CNLTools.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

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
 
infix operator --> { higherThan: Equatable associativity: right }

@discardableResult
public func --> <T, U>(left: T, right: (T) -> U) -> U {
    return right(left)
}

@discardableResult
public func --> <T, U>(left: T?, right: (T?) -> U?) -> U? {
    return right(left)
}

@discardableResult
public func --> <T>(left: T, right: (T) -> ()) -> T {
    right(left)
    return left
}

@discardableResult
public func --> <T>(left: T?, right: (T?) -> ()) -> T? {
    right(left)
    return left
}

