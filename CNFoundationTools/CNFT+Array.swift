//
//  CNFT+Array.swift
//  CNFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

public extension Array {
    
    public func indexOf(_ check: (Element) -> Bool) -> Int? {
        for (index, element) in self.enumerated() {
            if check(element) {
                return index
            }
        }
        return nil
    }
    
    public func lookup(_ check: (Element) -> Bool) -> Element? {
        for element in self {
            if check(element) {
                return element
            }
        }
        return nil
    }
    
    public func map<K, V>(_ transform: (Element) -> (key: K, value: V)) -> [K: V] {
        var result: [K: V] = [:]
        for item in self {
            let entry = transform(item)
            result[entry.key] = entry.value
        }
        
        return result
    }
    
    public func mapSkipNil<K, V>(_ transform: (Element) -> (key: K, value: V)?) -> [K: V] {
        var result: [K: V] = [:]
        for item in self {
            if let entry = transform(item) {
                result[entry.key] = entry.value
            }
        }
        
        return result
    }
    
    public func mapSkipNil<V>(_ transform: (Element) -> V?) -> [V] {
        var result: [V] = []
        for item in self {
            if let entry = transform(item) {
                result.append(entry)
            }
        }
        
        return result
    }
    
    public func exists(_ check: (Element) -> Bool) -> Bool {
        return lookup(check) != nil
    }
    
    public mutating func removeObject<U: Equatable>(_ object: U) {
        
        for (index, item) in self.enumerated() {
            if let itemToDelete = item as? U {
                if object == itemToDelete {
                    self.remove(at: index)
                    return
                }
            }
        }
        
    }
    
}

public extension Array where Element : Hashable {
    public var unique: [Element] {
        return Array(Set(self))
    }
}
