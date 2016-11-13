//
//  CNLFT+Int.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

public extension Int {
    
    // converts to string
    public var toString: String {
        return "\(self)"
    }
    
    // converts to string with Roman number
    public var toRomanString: String {
        let huns: [String] = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"]
        let tens: [String] = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"]
        let ones: [String] = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
        
        var value = self
        var res: String = ""
        while value >= 1000 {
            res += "M"
            value -= 1000
        }
        
        res += huns[value / 100]
        value = value % 100;
        res += tens[value / 10]
        value = value % 10;
        res += ones[value]
        return res
    }
    
}
