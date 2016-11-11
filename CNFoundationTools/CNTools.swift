//
//  CNTools.swift
//  CNFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

public func with<T>(_ target: T, doWith: (T) -> ()) {
    doWith(target)
}
