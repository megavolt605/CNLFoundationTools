//
//  CNLFT+Dictionary.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

public protocol CNLDictionaryDecodable {
    static func valueFrom(_ any: Any) -> Self?
}

public typealias CNLDictionary = [String: Any]
public typealias CNLArray = [CNLDictionary]

extension Dictionary {
    /// Maps dictionary values to the another dictionary with same keys, using transform closure for values
    ///
    /// - Parameter f: Transform closure
    /// - Returns: Dictionary with the same keys and transformed values
    public func map(_ transform: (Key, Value) -> Value) -> [Key:Value] {
        var ret = [Key: Value]()
        for (key, value) in self {
            ret[key] = transform(key, value)
        }
        return ret
    }
    
    /// Maps dictionary to the array, using transform function for values. It skips nil results
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
    public func mapSkipNil<K, V>(_ transform: ((Key, Value)) -> (K, V)?) -> [K: V] {
        var result: [K: V] = [:]
        for item in self {
            if let entry = transform(item) {
                result[entry.0] = entry.1
            }
        }
        
        return result
    }
    
    /// Filter the dictionary using closure
    ///
    /// - Parameter check: filtering closure
    /// - Returns: New dictionary with filtered keys:values
    public func filter(_ check: (Key, Value) -> Bool) -> [Key:Value] {
        var result = [Key: Value]()
        for (key, value) in self {
            if check(key, value) {
                result[key] = value
            }
        }
        return result
    }
    
    /// Merge dictionary with another dictionary and return result. When key values has intersections, values from the source dictionary will override existing values
    ///
    /// - Parameter source: Source dictionary
    /// - Returns: New dictionary with self and source elemenct
    public func merged(with source: [Key: Value]?) -> [Key: Value] {
        guard let source = source else { return self }
        var res = self
        
        for (key, value) in source {
            res[key] = value
        }
        
        return res
    }
    
    /// Merge dictionary with another dictionary (mutable). When key values has intersections, values from the source dictionary will override existing values
    ///
    /// - Parameter source: Source dictionary
    public mutating func merge(with source: [Key: Value]?) {
        guard let source = source else { return }
        for (key, value) in source {
            self[key] = value
        }
    }
    
    /// Get value for key with type check, returns default value when key doeas not exist either type check was failed
    ///
    /// - Parameters:
    ///   - name: Key value
    ///   - defaultValue: Default value
    /// - Returns: Value for the key (or defaultValue)
    public func value<T>(_ name: Key, _ defaultValue: T) -> T! where T: CNLDictionaryDecodable {
        if let data = self[name], let value = T.valueFrom(data) {
            return value
        }
        return defaultValue
    }
    
    /// Returns value for key with type check
    ///
    /// - Parameter name: Key value
    /// - Returns: Value for the key (or nil when type check was failed)
    public func value<T>(_ name: Key) -> T? where T: CNLDictionaryDecodable {
        if let data = self[name] {
            return T.valueFrom(data)
        }
        return nil
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
    
    /// Calls closure for each element of the array in the dictionary array value
    ///
    /// - Parameters:
    ///   - name: Key value for the array container
    ///   - closure: Closure to be called if type check successed
    public func array(_ name: Key, closure: (_ data: Any) -> Void) {
        if let possibleData = self[name] as? [Any] {
            possibleData.forEach { closure($0) }
        }
    }
}

extension Bool: CNLDictionaryDecodable {
    public static func valueFrom(_ any: Any) -> Bool? {
        return any as? Bool
    }
}

extension String: CNLDictionaryDecodable {
    public static func valueFrom(_ any: Any) -> String? {
        return any as? String
    }
}

extension Int: CNLDictionaryDecodable {
    public static func valueFrom(_ any: Any) -> Int? {
        return any as? Int
    }
}

extension Float: CNLDictionaryDecodable {
    public static func valueFrom(_ any: Any) -> Float? {
        return any as? Float
    }
}

extension Double: CNLDictionaryDecodable {
    public static func valueFrom(_ any: Any) -> Double? {
        return any as? Double
    }
}

extension URL: CNLDictionaryDecodable {
    public static func valueFrom(_ any: Any) -> URL? {
        return any as? URL
    }
}

extension Date: CNLDictionaryDecodable {
    public static func valueFrom(_ any: Any) -> Date? {
        if let data = any as? TimeInterval {
            return Date(timeIntervalSince1970: data)
        } else {
            return nil
        }
    }
}

extension Array: CNLDictionaryDecodable {
    public static func valueFrom(_ any: Any) -> Array? {
        return any as? Array
    }
}
