//
//  CNLFT+Dictionary.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    /// Get value for key with type check, returns default value when key doeas not exist either type check was failed
    ///
    /// - Parameters:
    ///   - name: Key value
    ///   - defaultValue: Default value
    /// - Returns: Value for the key (or defaultValue)
    public func value<T>(_ name: Key, _ defaultValue: T) -> T {
        let data = self[name]
        if let res = data as? T {
            return res
        }
        return defaultValue
    }
    
    /// Returns value for key with type check
    ///
    /// - Parameter name: Key value
    /// - Returns: Value for the key (or nil when type check was failed)
    public func value<T>(_ name: Key) -> T? {
        return self[name] as? T
    }
    
    /// Calls closure with sub-dictionary for key with type check
    ///
    /// - Parameters:
    ///   - name: Key value for dictionary container
    ///   - closure: Closure to be called if type check successed
    public func dictionary(_ name: Key, closure: (_ data: Dictionary) -> Void) {
        if let possibleData = self[name] as? Dictionary {
            closure(possibleData)
        }
    }
    
    /// Calls closure for each element of the array in the container
    ///
    /// - Parameters:
    ///   - name: Key value for the array container
    ///   - closure: Closure to be called if type check successed
    public func array(_ name: Key, closure: (_ data: Dictionary) -> Void) {
        if let possibleData = self[name] as? Array<Dictionary> {
            for item in possibleData {
                closure(item)
            }
        }
    }
    
    /// Special implementation `value<T>` function for Date class
    ///
    /// - Parameters:
    ///   - name: Key value
    ///   - defaultValue: Default value
    /// - Returns: Date struct with value of unix timestamp from the key, nil if type check was failed
    public func date(_ name: Key, _ defaultValue: Date? = nil) -> Date? {
        if let data = self[name] as? TimeInterval {
            return Date(timeIntervalSince1970: data)
        } else {
            return defaultValue
        }
    }
    
    /// Maps dictionary values to another dictionary with same keys, using transform closure for values
    ///
    /// - Parameter f: Transform closure
    /// - Returns: Dictionary with the same keys and transformed values
    public func map(_ transform: (Key, Value) -> Value) -> [Key:Value] {
        var ret = [Key:Value]()
        for (key, value) in self {
            ret[key] = transform(key, value)
        }
        return ret
    }
    
    /// Maps dictionary to array, using transform function for values. It skips nil results
    ///
    /// - Parameter transform: Transform closure
    /// - Returns: Array with non-nil results of transform closure
    public func mapSkipNil<V>(_ transform: ((Key, Value)) -> V?) -> [V] {
        var result: [V] = []
        for item in self {
            if let entry = transform(item) {
                result.append(entry)
            }
        }
        
        return result
    }
    
    /// Maps dictionary to another dictionary
    ///
    /// - Parameter transform: Transform closure (it mapped source pair of key-value to result pair)
    /// - Returns: Dictionary with transformed pairs key-value from the source, exluding nil transform results
    public func mapSkipNil<K,V>(_ transform: ((Key, Value)) -> (K, V)?) -> [K:V] {
        var result: [K:V] = [:]
        for item in self {
            if let entry = transform(item) {
                result[entry.0] = entry.1
            }
        }
        
        return result
    }
    
    /// Filter the dictionary using closure
    ///
    /// - Parameter f: <#f description#>
    /// - Returns: <#return value description#>
    public func filter(_ check: (Key, Value) -> Bool) -> [Key:Value] {
        var result = [Key:Value]()
        for (key, value) in self {
            if check(key, value) {
                result[key] = value
            }
        }
        return result
    }
    
    /// Merge dictionary with another dictionary. When key values has intersections, values from the source dictionary will override existing values
    ///
    /// - Parameter source: Source dictionary
    /// - Returns: New dictionary with self and source elemenct
    public func merge(_ source: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        var res = self
        
        for (key, value) in source {
            res[key] = value
        }
        
        return res
    }
    
}
