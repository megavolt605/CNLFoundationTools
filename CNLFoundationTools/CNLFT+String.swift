//
//  CNLFT+String.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation
import CommonCrypto

public extension String {
    
    /// Length of string (characters count)
    public var length: Int {
        return Array(self.characters).count
    }
    
    /// Character by index
    ///
    /// - Parameter i: index
    public subscript (i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }
    
    
    /// Character as String by index
    ///
    /// - Parameter i: index
    public subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    /// Substring with Range
    ///
    /// - Parameter r: range of indexes
    public subscript (r: CountableRange<Int>) -> String {
        let start = characters.index(startIndex, offsetBy: r.lowerBound)
        let end = characters.index(start, offsetBy: r.upperBound - r.lowerBound)
        return self[Range(start ..< end)]
    }
    
    /// Substring with Closed Range
    ///
    /// - Parameter r: range of indexes
    public subscript (r: CountableClosedRange<Int>) -> String {
        let start = characters.index(startIndex, offsetBy: r.lowerBound)
        let end = characters.index(start, offsetBy: r.upperBound - r.lowerBound + 1)
        return self[Range(start ..< end)]
    }
    
    /// Converts string to Double?
    public var toDouble: Double? {
        let nf = NumberFormatter()
        nf.decimalSeparator = "."
        return nf.number(from: self)?.doubleValue
    }
    
    /// Converts string to Int?
    public var toInt: Int? {
        if let double = toDouble {
            return Int(double)
        } else {
            return nil
        }
    }
    
    /// Inserts substring in file or url path before extension (last "." character)
    ///
    /// - Parameter suffix: substring to insert
    /// - Returns: modified string
    public func appendSuffixBeforeExtension(_ suffix: String) -> String {
        let regex = try? NSRegularExpression(pattern: "(\\.\\w+$)", options: [])
        return regex!.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.length), withTemplate: "\(suffix)$1")
    }
    
    /// Returns MD5 hash value of the string
    public var md5: String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        var hash = ""
        for i in 0..<digestLen {
            hash += String(format: "%02x", result[i])
        }
        
        result.deallocate(capacity: digestLen)
        
        return String(format: hash as String)
    }

    /// Return truncated string by specified length, and append trailing stirng (if any)
    ///
    /// - Parameters:
    ///   - length: max length for truncation
    ///   - trailing: trailing appendix
    /// - Returns: Result string
    public func truncate(_ length: Int, trailing: String? = nil) -> String {
        if self.length > length {
            return self.substring(to: self.characters.index(self.startIndex, offsetBy: length)) + (trailing ?? "")
        } else {
            return self
        }
    }
    
    /// Checks is string contans a valid e-mail address
    public var isEmail: Bool {
        if self != "" {
            let mask = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", mask)
            return emailTest.evaluate(with: self)
        }
        return false
    }
    
    fileprivate func _applyFormat(_ format: String, placeholderChar placeholder: Character) -> (data: String, isCompleted: Bool) {
        var result: String = ""
        var dataIndex = startIndex
        var formatIndex = format.startIndex
        while (dataIndex < endIndex) && (formatIndex < format.endIndex) {
            let fCh = format.characters[formatIndex]
            if fCh == placeholder {
                result.append(characters[dataIndex])
                dataIndex = index(after: dataIndex)
                formatIndex = format.index(after: formatIndex)
            } else {
                result.append(fCh)
                formatIndex = format.index(after: formatIndex)
            }
        }
        return (
            data: result,
            isCompleted: (dataIndex == endIndex) && (formatIndex == format.endIndex)
        )
    }
    
    /// Applies specified format to string
    ///
    /// - Parameters:
    ///   - format: Format string
    ///   - placeholder: Placeholder character used in format string
    /// - Returns: Formatted string
    public func applyFormat(_ format: String, placeholderChar placeholder: Character = "#") -> String {
        return _applyFormat(format, placeholderChar: placeholder).data
    }
    
    /// Checks string for completly applying specified format
    ///
    /// - Parameters:
    ///   - format: Format string
    ///   - placeholder: Placeholder character used in format string
    /// - Returns: Result of check
    public func checkFormat(_ format: String, placeholderChar placeholder: Character = "#") -> Bool {
        return _applyFormat(format, placeholderChar: placeholder).isCompleted
    }
    
    /// Extracts digits from the string
    public var digitsOnly: String {
        let nonDigits = CharacterSet.decimalDigits.inverted
        return components(separatedBy: nonDigits).joined(separator: "")
    }
    
}
