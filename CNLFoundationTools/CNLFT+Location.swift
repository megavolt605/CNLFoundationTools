//
//  CNLFT+Location.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 02/03/2017.
//  Copyright © 2017 Complex Numbers. All rights reserved.
//

import Foundation
import CoreLocation

// MARK: - Extension of CLLocationCoordinate2D
public extension CLLocationCoordinate2D {
    
    /// String value representation (comma separated)
    public var stringValue: String {
        return "\(latitude),\(longitude)"
    }
    
}

// MARK: - CLLocation
public extension CLLocation {
    
    /// String value representation
    public var stringValue: String {
        return coordinate.stringValue
    }
    
}

/// Sperical rectangle struct
public struct CNLLocationCoordinate2DRect {
    /// Bottom left coordinate
    public var bottomLeft: CLLocationCoordinate2D
    /// Bottom right coordinate
    public var bottomRight: CLLocationCoordinate2D
    /// Top left coordinate
    public var topLeft: CLLocationCoordinate2D
    /// Top right coordinate
    public var topRight: CLLocationCoordinate2D
    
    /// Default initializer
    ///
    /// - Parameters:
    ///   - bottomLeft: Bottom left coordinate
    ///   - bottomRight: Bottom right coordinate
    ///   - topLeft: Top left coordinate
    ///   - topRight: Top right coordinate
    public init(bottomLeft: CLLocationCoordinate2D, bottomRight: CLLocationCoordinate2D, topLeft: CLLocationCoordinate2D, topRight: CLLocationCoordinate2D) {
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
        self.topLeft = topLeft
        self.topRight = topRight
    }
    
    /// Default initializer. All coordinates sets to zero
    public init() {
        bottomLeft = CLLocationCoordinate2D()
        bottomRight = CLLocationCoordinate2D()
        topLeft = CLLocationCoordinate2D()
        topRight = CLLocationCoordinate2D()
    }

}
