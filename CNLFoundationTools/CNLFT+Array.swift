//
//  CNLFT+Array.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

public extension Array {
    
    /// Lookup value within array with check closure
    ///
    /// - Parameter check: Check element closure
    /// - Returns: Found element when founded or nil, when not
    public func lookup(_ check: (Element) -> Bool) -> Element? {
        if let idx = index(where: check) {
            return self[idx]
        } else {
            return nil
        }
    }
    
    /// Transform Array to Dictionary
    ///
    /// - Parameter transform: Transform closure
    /// - Returns: Result dictionary
    public func map<K, V>(_ transform: (Element) -> (key: K, value: V)) -> [K: V] {
        var result: [K: V] = [:]
        for item in self {
            let entry = transform(item)
            result[entry.key] = entry.value
        }
        return result
    }
    
    /// Transform Array to Dictionary (without nil transforms)
    ///
    /// - Parameter transform: Transform closure
    /// - Returns: Result dictionary
    public func mapSkipNil<K, V>(_ transform: (Element) -> (key: K, value: V)?) -> [K: V] {
        var result: [K: V] = [:]
        for item in self {
            if let entry = transform(item) {
                result[entry.key] = entry.value
            }
        }
        return result
    }
    
    /// Transform Array (without nil transforms)
    ///
    /// - Parameter transform: Transform closure
    /// - Returns: Result array
    public func mapSkipNil<V>(_ transform: (Element) -> V?) -> [V] {
        var result: [V] = []
        for item in self {
            if let entry = transform(item) {
                result.append(entry)
            }
        }
        return result
    }
    
    /// Check element existance
    ///
    /// - Parameter check: Check closure
    /// - Returns: True when exists, false when not
    public func exists(_ check: (Element) -> Bool) -> Bool {
        return lookup(check) != nil
    }
    
    /// Remove first founded object from the array, that equals to scecified object (see Equatable protocol)
    ///
    /// - Parameter object: Object to remove
    @discardableResult
    public mutating func removeObject<U: Equatable>(_ object: U) -> Bool {
        for (index, item) in self.enumerated() {
            if let itemToDelete = item as? U {
                if object == itemToDelete {
                    self.remove(at: index)
                    return true
                }
            }
        }
        return false
    }
    
}

public extension Array where Element : Hashable {

    /// Returns array with unique elements (elements of the array must be conformed to Hashable)
    public var unique: [Element] {
        return Array(Set(self))
    }

}
