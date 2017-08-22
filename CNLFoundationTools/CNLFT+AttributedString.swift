//
//  CNLFT+AttributedString.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

public func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
    let result = NSMutableAttributedString()
    result.append(lhs)
    result.append(rhs)
    return result
}

extension NSAttributedString {
    public static func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
        // swiftlint:disable:next shorthand_operator
        lhs = lhs + rhs
    }
}
