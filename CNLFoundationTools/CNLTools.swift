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
/// with(label) { label
///     text = "text"
///     font = someFont
/// }

public func with<T>(_ target: T?, doWith: (T) -> ()) -> T? {
    if let target = target {
        doWith(target)
    }
    return target
}

public func with<T>(_ target: T, doWith: (T) -> ()) -> T {
    doWith(target)
    return target
}
