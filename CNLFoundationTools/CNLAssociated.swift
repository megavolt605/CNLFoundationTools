//
//  CNLAssociated.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

/// Generic helper class for assotiating stored variables within extensions
///
/// Typical usage:
/// ```
/// var variableKey = "variableKey"
/// extension "some" {
///     var "variable": "type" {
///         get {
///             if let value = (objc_getAssociatedObject(self, &variableKey) as? CNLAssociated<"type">)?.closure {
///                 return value
///             } else {
///                 return "defaultValue"
///             }
///         }
///         set {
///             objc_setAssociatedObject(self, &variableKey, CNLAssociated<"type">(closure: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
///         }
///     }
/// }
/// ```
open class CNLAssociated<T>: NSObject, NSCopying {
    
    private var value: T?
    
    /// Default initializer with value
    ///
    /// - Parameter value: Value
    public convenience init(value: T?) {
        self.init()
        self.value = value
    }
    
    /// Default copy function
    ///
    /// - Parameter zone: Zone
    /// - Returns: Copied instance
    @objc open func copy(with zone: NSZone?) -> Any {
        let wrapper: CNLAssociated<T> = CNLAssociated<T>()
        wrapper.value = value
        return wrapper
    }
    
}
