//
//  CNAssociated.swift
//  CNFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

/// Helper class for assotiating variables within extensions
///
/// Typical usage:
/// var variableKey = "variableKey"
/// extension "some"
///     var "variable": "type" {
///         get {
///             if let value = (objc_getAssociatedObject(self, &variableKey) as? CNAssociated<"type">)?.closure {
///                 return value
///             } else {
///                 return "defaultValue"
///             }
///         }
///         set {
///             objc_setAssociatedObject(self, &variableKey, CNAssociated<"type">(closure: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
///         }
///     }
/// end

open class CNAssociated<T>: NSObject, NSCopying {
    
    open var closure: T?
    
    public convenience init(closure: T?) {
        self.init()
        self.closure = closure
    }
    
    @objc open func copy(with zone: NSZone?) -> Any {
        let wrapper: CNAssociated<T> = CNAssociated<T>()
        wrapper.closure = closure
        return wrapper
    }
}
