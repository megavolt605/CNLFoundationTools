# CNLFoundationTools
Basic tools and extensions for Foundation framework

<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
<a href="https://cocoapods.org/pods/CNLFoundationTools"><img src="https://img.shields.io/badge/pod-0.0.9-blue.svg" alt="CocoaPods compatible" /></a>

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
Returns Roman representation of the value
```swift
print(1234.toRomanString) // prints "MCCXXXIV"
```

### Stirng extensions

Length of string (characters count):
```swift
"1234".length /// 4
```

Returns character by index
```swift
let ch: Character = "abcd"[2] // "c"
```

Returns character as String by index:
```swift
let ch: String = "abcd"[2] // "c"
```

Returns substring with Countable Range:
```swift
let st = "abcdef"[2..<4] // "cd"
```

Returns substring with Closed Range
```swift
let st = "abcdef"[2...4] // "cde"
```

Converts string to Double? (optional)
```swift
let d0 = "123.6".toDouble // 123.6
let d1 = "abcd".toDouble // nil
```

Converts string to Int? (optional)
```swift
let d0 = "123.6".toInt // 123
let d1 = "123".toInt // 123
let d2 = "abcd".toInt // nil
```

Inserts substring in file or url path before extension (last "." character)
```swift
let s = "http://host/path/subpath/filename.ext".appendSuffixBeforeExtension("_suffix") // "http://host/path/subpath/filename_suffix.ext"
```

Returns MD5 hash value of the string
```swift 
let s = "some string".md5 // "5ac749fbeec93607fc28d666be85e73a"
```

Returns truncated string by specified length, and append trailing stirng (if any)
```swift
let s0 = "some string".truncate(4) // "some"
let s1 = "some string".truncate(40) // "some string"
let s2 = "some string".truncate(4, trailing: "...") // "some..."
```

Checks is string contans a valid e-mail address
```swift
let b0 = "aa@aa.aa".isEmail // true
let b1 = "aa@aa".isEmail // false
```

Applies specified format to string. Parameters:
  - `format`: Format string
  - `placeholder`: Placeholder character used in format string

Returns formatted string

Usage:
```swift
let s0 = "".applyFormat("#-###-###-####") // ""
let s1 = "1".applyFormat("#-###-###-####") // "1"
let s2 = "12".applyFormat("#-###-###-####") // "1-2"
let s3 = "12345678".applyFormat("#-###-###-####") // "1-234-567-8"
let s4 = "12345678901".applyFormat("#-###-###-####") // "1-234-567-8901"
let s5 = "123456789012345".applyFormat("#-###-###-####") // "1-234-567-8901"
```

Checks string for completly applying specified format. Parameters:
  - `format`: Format string
  - `placeholder`: Placeholder character used in format string

Returns true when string is completly applies format
```swift
let b0 = "".checkFormat("#-###-###-####") // false
let b1 = "1".checkFormat("#-###-###-####") // false
let b2 = "12".checkFormat("#-###-###-####") // false
let b3 = "12345678".checkFormat("#-###-###-####") // false
let b4 = "12345678901".checkFormat("#-###-###-####") // true
let b5 = "123456789012345".checkFormat("#-###-###-####") // false
```

Extracts digits from the string
```swift
let s = "a1b23c456d".digitsOnly // "123456"
```

### Array extensions
Lookup value within array with check closure
```swift
let a0 = [10,20,30,40,50]
let r0 = a0.lookup { return $0 == 30 } // 30
```

Transform Array to Dictionary
```swift
let a0 = [10,20,30,40,50]
let r1: [String: Int] = a0.map { return (key: "key\($0)", value: $0 * 10) } // ["key10": 100, "key20": 200, "key30": 300, "key50": 500, "key40": 400]
```

Transform Array (without nil transforms)
```swift
let a1: [Int?] = [10,20,nil,30,40,nil,50]
let r2 = a1.mapSkipNil { return $0 } // [10, 20, 30, 40, 50]
```

Transform Array to Dictionary (without nil transforms)
```swift
let a1: [Int?] = [10,20,nil,30,40,nil,50]
let r3: [String: Int] = a1.mapSkipNil {
    if let value = $0 {
        return (key: "key\(value)", value: value * 10)
    }
    return nil
} // ["key10": 100, "key20": 200, "key30": 300, "key50": 500, "key40": 400]
```

Check element existance
```swift
let a0 = [10,20,30,40,50]
let r4 = a0.exists { $0 == 30 } // true
let r5 = a0.exists { $0 == 300 } // false
```

Remove first founded object from the array, that equals to scecified object (see `Equatable` protocol)
```swift
var r6 = [10,20,30,40,50]
r6.removeObject(30) // [10, 20, 40, 50]
```

Resurns array with unique elements (elements of the array must be conformed to `Hashable` protocol)
```swift
let r7 = ["a", "b", "c", "a", "c", "d", "c", "e"].unique // ["b", "e", "a", "d", "c"]
```

### Dictionary extensions

## TODO: Update README.md for:
### Date extensions
### TimeZone extensions
### Data extensions
### AttributedString extensions
### Timer extensions

## Author

[Igor Smirnov](https://www.github.com/megavolt605 "Igor Smirnov Github")

## License

CNLFoundationTools is released under [MIT license](https://raw.githubusercontent.com/xmartlabs/XLActionController/master/LICENSE) and copyrighted by Igor Smirnov.
