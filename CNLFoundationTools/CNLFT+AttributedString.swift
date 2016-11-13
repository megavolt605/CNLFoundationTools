//
//  CNLFT+AttributedString.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

public extension NSAttributedString {
    
    /// Combine array of NSAttributedString into single one
    ///
    /// - Parameter strings: Array of NSAttributedString
    /// - Returns: Result of mixup (NSAttributedString)
    public class func mixAttributedStrings(_ strings: [NSAttributedString]) -> NSAttributedString {
        return strings.reduce(NSMutableAttributedString()) {
            $0.append($1)
            return $0
        }
    }
    
    public typealias CNLStringWithAttrs = (string: String, attrs: Dictionary<String, Any>?)
    
    /// Combine tuples (string, attributes) into NSAttributedString
    ///
    /// - Parameter strings: Array of strings with attributes
    /// - Returns: Result of mixup (NSAttributedString)
    public class func mixStrings(_ strings: [CNLStringWithAttrs]) -> NSAttributedString {
        let astrings = strings.map { string in
            return NSAttributedString(string: string.string, attributes: string.attrs)
        }
        return mixAttributedStrings(astrings)
    }
    
}
