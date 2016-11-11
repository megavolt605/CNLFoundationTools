//
//  CNFT+Dictionary.swift
//  CNFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    public func value<T>(_ name: Key, _ defaultValue: T) -> T {
        let data = self[name]
        if let res = data as? T {
            return res
        }
        return defaultValue
    }
    
    public func value<T>(_ name: Key) -> T? {
        return self[name] as? T
    }
    
    public func dictionary(_ name: Key, closure: (_ data: Dictionary) -> Void) {
        if let possibleData = self[name] as? Dictionary {
            closure(possibleData)
        }
    }
    
    public func array(_ name: Key, closure: (_ data: Dictionary) -> Void) {
        if let possibleData = self[name] as? Array<Dictionary> {
            for item in possibleData {
                closure(item)
            }
        }
    }
    
    public func string(_ name: Key, _ defaultValue: String? = nil) -> String? {
        let data = self[name]
        if let res = data as? String {
            return res
        }
        return defaultValue
    }
    
    public func int(_ name: Key, _ defaultValue: Int? = nil) -> Int? {
        let data = self[name]
        if let res = data as? Int {
            return res
        }
        return defaultValue
    }
    
    public func bool(_ name: Key, _ defaultValue: Bool? = nil) -> Bool? {
        let data = self[name]
        if let res = data as? Bool {
            return res
        }
        return defaultValue
    }
    
    public func float(_ name: Key, _ defaultValue: Float? = nil) -> Float? {
        let data = self[name]
        if let res = data as? Float {
            return res
        }
        return defaultValue
    }
    
    public func double(_ name: Key, _ defaultValue: Double? = nil) -> Double? {
        let data = self[name]
        if let res = data as? Double {
            return res
        }
        return defaultValue
    }
    
    public func date(_ name: Key, _ defaultValue: Date? = nil) -> Date? {
        if let data = self[name] as? TimeInterval {
            return Date(timeIntervalSince1970: data)
        } else {
            return defaultValue
        }
    }
    
    public func map(_ f: (Key, Value) -> Value) -> [Key:Value] {
        var ret = [Key:Value]()
        for (key, value) in self {
            ret[key] = f(key, value)
        }
        return ret
    }
    
    public func mapSkipNil<V>(_ transform: ((Key, Value)) -> V?) -> [V] {
        var result: [V] = []
        for item in self {
            if let entry = transform(item) {
                result.append(entry)
            }
        }
        
        return result
    }
    
    public func mapSkipNil<K,V>(_ transform: ((Key, Value)) -> (K, V)?) -> [K:V] {
        var result: [K:V] = [:]
        for item in self {
            if let entry = transform(item) {
                result[entry.0] = entry.1
            }
        }
        
        return result
    }
    
    public func filter(_ f: (Key, Value) -> Bool) -> [Key:Value] {
        var ret = [Key:Value]()
        for (key, value) in self {
            if f(key, value) {
                ret[key] = value
            }
        }
        return ret
    }
    
    public func merge(_ source: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        var res = self
        
        for (key, value) in source {
            res[key] = value
        }
        
        return res
    }
    
}
