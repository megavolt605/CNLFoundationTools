# CNLFoundationTools
Basic tools and extensions for Foundation framework

<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
<a href="https://cocoapods.org/pods/CNLFoundationTools"><img src="https://img.shields.io/badge/pod-0.0.10-blue.svg" alt="CocoaPods compatible" /></a>

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects.

Specify CNLFoundationTools into your project's Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'CNLFoundationTools'
```

## Usage

### CNLAssociated
```swift
fileprivate var variableKey = "variableKey"
extension "entity"
    var "variable": "type" {
        get {
            if let value = (objc_getAssociatedObject(self, &variableKey) as? CNLAssociated<"type">)?.closure {
                return value
            } else {
                return "defaultValue"
            }
        }
        set {
            objc_setAssociatedObject(self, &variableKey, CNLAssociated<"type">(closure: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
end
```

For example, following code will add `stringTag` variable of optional type `String` (i.e. `String?`) to all `UIView` and it descedants:

```swift
fileprivate var UIKitStringTag = "UIKitStringTag"
extension UIView
    var stringTag: String? {
        get {
            if let value = (objc_getAssociatedObject(self, &UIKitStringTag) as? CNLAssociated<String?>)?.closure {
                return value
            } else {
                return nil
            }
        }
        set {
            objc_setAssociatedObject(self, &UIKitStringTag, CNLAssociated<String?>(closure: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
end
``` 

### CNLLog
Adds emoji symbols to the log strings

There is some log levels defined:
```swift
switch self {
    case .debug: return "➡️"
    case .network: return "🌐"
    case .info: return "💡"
    case .warning: return "❗"
    case .error: return "❌"
}
```

Example of usage: 
```swift
CNLLog("My log message", level: .info)
```

Output will something like this:
```
💡 My log message
```

### CNLDispatch

Runs `backgoundClosure` async in global queue, then calls `completionClosure` async in main queue:
```swift
func asyncGlobal (_ backgroundClosure: @escaping () -> Void, _ completionClosure: @escaping (() -> Void) )
```

Runs `backgoundClosure` async in global queue:
```swift
func asyncGlobal (_ backgroundClosure: @escaping () -> Void)
```

Runs `backgoundClosure` async in global queue, then calls `completionClosure` async in main queue with result of `backgroundClosure`:
```swift
func asyncGlobal<R> (_ backgroundClosure: @escaping () -> R, _ completionClosure: @escaping ((_ result: R) -> ()) )
```

Runs `backgoundClosure` sync in main queue:
```swift
func syncMain (_ backgroundClosure: @escaping () -> Void )
```

Runs `backgoundClosure` async in main queue, then calls `completionClosure`:
```swift
func asyncMain (_ backgroundClosure: @escaping () -> Void, _ completionClosure: @escaping (() -> Void) )
```

Runs `backgoundClosure` async in main queue:
```swift
func asyncMain (_ backgroundClosure: @escaping () -> Void )
```

Runs `backgoundClosure` async in main queue, then calls `completionClosure` with result of `backgroundClosure`:
```swift
func asyncMain<R> (_ backgroundClosure: @escaping () -> R, _ completionClosure: @escaping ((_ result: R) -> ()) )
```

Locks execution of the `closure` by calling `objc_sync_enter` and `objc_sync_exit` calls, assotiated with the `object`:
```swift
syncCritical(self) {
    // some thead critical (not thread-safe) code
}
```

### CNLURLCache
With CNLURLCache you can specify custom expires interval

Usage:
```swift
let urlCache = CNLURLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 200 * 1024 * 1024, diskPath: "MyAppNetworkCache")
urlCache.cacheExpired = 1.0 * 60.0 * 60.0 // one hour, default is 24h
URLCache.shared = urlCache
``` 

### CNLDeepLink, CNLDeepLinkComponents, CNLDeepLinkParameters
Use CNLDeepLink to parse deep link url into components and parameters

Usage:
```swift
let url = URL(string: "myapp://host/path?param1=123&param2=abc")!
if let deepLinkComponents = CNLDeepLink.parseURL(url) {
    print(deepLinkComponents.scheme)
    print(deepLinkComponents.host)
    print(deepLinkComponents.path)
    if let param: Int = deepLinkComponents.parameters["param1"] {
        print(param)
    }
    if let param: String = deepLinkComponents.parameters["param2"] {
        print(param)
    }
}
```

### Int extensions
```swift
// Returns Roman representation of the value
print(1234.toRomanString) // prints "MCCXXXIV"
```

### Stirng extensions

```swift
// Length of string (characters count):
let l = "1234".length /// 4

// Returns character by index
let ch: Character = "abcd"[2] // "c"

// Returns character as String by index:
let ch: String = "abcd"[2] // "c"

// Returns substring with Countable Range:
let st = "abcdef"[2..<4] // "cd"

// Returns substring with Closed Range
let st = "abcdef"[2...4] // "cde"

// Converts string to Double? (optional)
let d0 = "123.6".toDouble // 123.6
let d1 = "abcd".toDouble // nil

// Converts string to Int? (optional)
let d0 = "123.6".toInt // 123
let d1 = "123".toInt // 123
let d2 = "abcd".toInt // nil

// Inserts substring in file or url path before extension (last "." character)
let s = "http://host/path/subpath/filename.ext".appendSuffixBeforeExtension("_suffix") // "http://host/path/subpath/filename_suffix.ext"

// Returns MD5 hash value of the string 
let s = "some string".md5 // "5ac749fbeec93607fc28d666be85e73a"

// Returns truncated string by specified length, and append trailing stirng (if any)
let s0 = "some string".truncate(4) // "some"
let s1 = "some string".truncate(40) // "some string"
let s2 = "some string".truncate(4, trailing: "...") // "some..."

// Checks is string contans a valid e-mail address
let b0 = "aa@aa.aa".isEmail // true
let b1 = "aa@aa".isEmail // false

// Applies specified format to string. Parameters:
//  - format: Format string
//  - placeholder: Placeholder character used in format string
// Returns formatted string
// Usage:
let s0 = "".applyFormat("#-###-###-####") // ""
let s1 = "1".applyFormat("#-###-###-####") // "1"
let s2 = "12".applyFormat("#-###-###-####") // "1-2"
let s3 = "12345678".applyFormat("#-###-###-####") // "1-234-567-8"
let s4 = "12345678901".applyFormat("#-###-###-####") // "1-234-567-8901"
let s5 = "123456789012345".applyFormat("#-###-###-####") // "1-234-567-8901"

// Checks string for completly applying specified format. Parameters:
//  - `format`: Format string
//  - `placeholder`: Placeholder character used in format string
// Returns true when string is completly applies format
let b0 = "".checkFormat("#-###-###-####") // false
let b1 = "1".checkFormat("#-###-###-####") // false
let b2 = "12".checkFormat("#-###-###-####") // false
let b3 = "12345678".checkFormat("#-###-###-####") // false
let b4 = "12345678901".checkFormat("#-###-###-####") // true
let b5 = "123456789012345".checkFormat("#-###-###-####") // false

// Extracts digits from the string
let s = "a1b23c456d".digitsOnly // "123456"
```

### Array extensions
```swift
// Lookup value within array with check closure
let a0 = [10,20,30,40,50]
let r0 = a0.lookup { return $0 == 30 } // 30

// Transform Array to Dictionary
let a0 = [10,20,30,40,50]
let r1: [String: Int] = a0.map { return (key: "key\($0)", value: $0 * 10) } // ["key10": 100, "key20": 200, "key30": 300, "key50": 500, "key40": 400]

// Transform Array (without nil transforms)
let a1: [Int?] = [10,20,nil,30,40,nil,50]

// Transform Array to Dictionary (without nil transforms)
let a1: [Int?] = [10,20,nil,30,40,nil,50]
let r3: [String: Int] = a1.mapSkipNil {
    if let value = $0 {
        return (key: "key\(value)", value: value * 10)
    }
    return nil
} // ["key10": 100, "key20": 200, "key30": 300, "key50": 500, "key40": 400]

// Check element existance
let a0 = [10,20,30,40,50]
let r4 = a0.exists { $0 == 30 } // true
let r5 = a0.exists { $0 == 300 } // false

// Remove first founded object from the array, that equals to scecified object (see `Equatable` protocol)
var r6 = [10,20,30,40,50]
r6.removeObject(30) // [10, 20, 40, 50]

// Returns array with unique elements (elements of the array must be conformed to `Hashable` protocol)
let r7 = ["a", "b", "c", "a", "c", "d", "c", "e"].unique // ["b", "e", "a", "d", "c"]
```

### Dictionary extensions
``` swift 
// Get value for key with type check, returns default value when key does not exist either type check was failed
let d0: [String: Any] = ["k1": 10, "k2": 20, "k3": 30, "k4": 40, "k5": 50, "ddd": 1482673784.0]
let r0: Int? = d0.value("k1") // 10
let r1: Int? = d0.value("k10") // nil
let r2: Int = d0.value("k10", -1) // -1

// Special implementation value<T> function for Date class
let r3 = d0.date("ddd") // Dec 25, 2016, 4:49 PM

// Checks if `Dictionary` exists for the key, calls closure for it
let d1: [String: Any] = ["data1": ["k1": 10, "k2": 20, "k3": 30, "k4": 40, "k5": 50, "ddd": 1482673784.0], "data2": [1,2,3,4,5]]
d1.dictionary("data1") { print($0) } // prints "data1" dictionary, i.e. ["k2": 20.0, "k5": 50.0, "k4": 40.0, "k3": 30.0, "ddd": 1482673784.0, "k1": 10.0]

// Checks if Array<Any> exists for the key, calls closure for each array element
let d2: [String: Any] = ["data1": ["k1": 10, "k2": 20, "k3": 30, "k4": 40, "k5": 50, "ddd": 1482673784.0], "data2": [1,2,3,4,5]]
d2.array("data2") {
    print($0)
}

// Maps dictionary values to another dictionary with same keys, using transform closure for values
let d3: [String: Int] = ["k1": 10, "k2": 20, "k3": 30, "k4": 40, "k5": 50]
let r6 = d3.map { key, value in return value * 10 } // ["k2": 200, "k5": 500, "k4": 400, "k3": 300, "k1": 100]

// Maps dictionary to the array, using transform function for values. It skips nil results
let d4: [String: Int?] = ["k1": 10, "k2": 20, "k3": nil, "k4": 40, "k5": 50]
let r7: [Int] = d4.mapSkipNil { key, value in
    if let v = value {
        return v * 100
    }
    return nil
} // [2000, 5000, 4000, 1000]

// Maps dictionary to another dictionary
let r8: [String: Int] = d4.mapSkipNil { key, value in
    if let v = value {
        return (key + "!", v * 100)
    }
    return nil
} // ["k1!": 1000, "k5!": 5000, "k4!": 4000, "k2!": 2000]

// Filter the dictionary using closure
let d9: [String: Int] = ["k1": 10, "k2": 20, "k3": 30, "k4": 40, "k5": 50]
let r9 = d9.filter { key, value in return value > 20 } // ["k5": 50, "k3": 30, "k4": 40]

// Merge dictionary with another dictionary. When key values has intersections, values from the source dictionary will override existing values
let da1: [String: Int] = ["k1": 10,  "k2": 20, "k3": 30,  "k4": 40, "k5": 50]
let da2: [String: Int] = ["k10": 100, "k2": 200, "k30": 300, "k4": 400, "k50": 500]
let ra = da1.merge(da2) // ["k5": 50, "k50": 500, "k2": 200, "k30": 300, "k4": 400, "k10": 100, "k3": 30, "k1": 10]
```

### Date extensions
```swift
/// Convert date from UTC
let d0 = Date() // "Dec 25, 2016, 7:37 PM"
let r0 = d0.fromUTC // "Dec 25, 2016, 10:37 PM" - +3 from UTC timezone at the moment

// Convert date to UTC
let r1 = r0.toUTC // "Dec 25, 2016, 7:37 PM"

// Convert date to string with format specified
let r2 = d0.toStringWithFormat(format: "MM-dd-YYYY") // "12-25-2016"

// String with ISO date
let r3 = d0.ISODate // "2016-12-25"

// Stirng with ISO time
let r4 = d0.ISOTime // "16:37:21.406000"

// String with ISO date and time
let r5 = d0.ISODateTime // "2016:12:25 16:37:21"

// Additional date comparision operators (<= , >=)
let d6a = Date()
let d6b = d6a.addingTimeInterval(10.0)
print(d6a <= d6b) // true
print(d6a >= d6b) // false

print(d6a >= d6a) // true
```

### TimeZone extensions
```swift
// String with timezone of the date (ex: +0300, -0200, etc.)
let r0 = TimeZone.localTimeZoneString // "+0300"
```

### Data extensions
```swift
let d0 = "abcd😎".data(using: String.Encoding.utf8)! // 8 bytes

// Hexadecimal string representation of the data
let r0 = d0.toHexString // "61626364F09F988E"


// UTF8 String representation of the data
let r1 = d0.toString() // "abcd😎"

// String representation of the data with specified encoding
let r2 = d0.toString(.utf8) // "abcd😎"

// String with MD5 hash value of the data
let r3 = d0.md5 // "3ba8a2f354b10efdf1bd7658adb46365"
```

### AttributedString extensions
```swift
// Combine array of NSAttributedString into single one
let as0 = NSAttributedString(string: "test1", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 10.0)])
let as1 = NSAttributedString(string: "test2", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 16.0)])
let r0 = NSAttributedString.mixAttributedStrings([as0, as1])

// Combine tuples (string, attributes) into NSAttributedString
let a0 = CNLStringWithAttrs(string: "test3", attrs: [NSFontAttributeName : UIFont.systemFont(ofSize: 10.0)])
let a1 = CNLStringWithAttrs(string: "test4", attrs: [NSFontAttributeName : UIFont.systemFont(ofSize: 16.0)])
let r1 = NSAttributedString.mixStrings([a0, a1])
```

### Timer extensions
```swift
// Creates disposable timer and schedule it to invoke handler after delay
let t0 = Timer.schedule(delay: 0.5) { _ in
    // some delayed code
}

// Creates timer and schedule it to invoke handler after delay, repeating with specified interval
let t1 = Timer.schedule(repeatInterval: 10.0) { timer in
    // some repeated code
    
    // when you need to remove timer from run loop, just call:
    CFRunLoopRemoveTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
}

let t2 = Timer.schedule(delay: 0.5, repeatInterval: 10.0) { timer in
    // some repeated code
    
    // when you need to remove timer from run loop, just call:
    CFRunLoopRemoveTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
}
```

## Author

[Igor Smirnov](https://www.github.com/megavolt605 "Igor Smirnov Github")

## License

CNLFoundationTools is released under [MIT license](https://raw.githubusercontent.com/xmartlabs/XLActionController/master/LICENSE) and copyrighted by Igor Smirnov.
