//
//  CNLFT+Data.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation
import CommonCrypto

public extension Data {
    
    /// Hexadecimal string representation of the data
    ///
    /// - Returns: String with data
    public var toHexString: String {
        
        var hexString: String = ""
        let dataBytes = (self as NSData).bytes.bindMemory(to: CUnsignedChar.self, capacity: self.count)
        
        for i in 0..<count {
            hexString +=  String(format: "%02X", dataBytes[i])
        }
        
        return hexString
    }
    
    /// UTF8 String representation of the data
    public var toString: String? {
        return String(data: self, encoding: .utf8)
    }
    
    /// String representation of the data with specified encoding
    ///
    /// - Returns: String with data
    public func toString(_ encoding: String.Encoding = .utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
    
    /// String with MD5 hash value of the data
    ///
    /// - Returns: MD5 string
    public var md5: String {
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        var hash = ""
        
        withUnsafeBytes() { (bytes: UnsafePointer<CChar>) in
            CC_MD5(bytes, CC_LONG(count), result)
            for i in 0..<digestLen {
                hash += String(format: "%02x", result[i])
            }
            result.deallocate(capacity: digestLen)
        }
        return String(format: hash as String)
    }
    
}
