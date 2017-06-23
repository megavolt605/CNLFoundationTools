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

public struct CNLLocationCoordinate2DRect {
    public var bottomLeft: CLLocationCoordinate2D
    public var bottomRight: CLLocationCoordinate2D
    public var topLeft: CLLocationCoordinate2D
    public var topRight: CLLocationCoordinate2D
    
    public init(bottomLeft: CLLocationCoordinate2D, bottomRight: CLLocationCoordinate2D, topLeft: CLLocationCoordinate2D, topRight: CLLocationCoordinate2D) {
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
        self.topLeft = topLeft
        self.topRight = topRight
    }

}
