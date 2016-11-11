//
//  CNAssociated.swift
//  CNFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

/// Class used for assotiating vaues within extension variables
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
