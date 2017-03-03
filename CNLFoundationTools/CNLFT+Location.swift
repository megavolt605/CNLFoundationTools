//
//  CNLFT+Location.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 02/03/2017.
//  Copyright © 2017 Complex Numbers. All rights reserved.
//

import Foundation
import CoreLocation

public extension CLLocationCoordinate2D {
    
    public var stringValue: String {
        return "\(latitude),\(longitude)"
    }
    
}

public extension CLLocation {
    
    public var stringValue: String {
        return coordinate.stringValue
    }
    
}
