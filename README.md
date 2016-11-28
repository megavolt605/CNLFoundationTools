# CNLFoundationTools
Basic tools and extensions for Foundation framework

<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
<a href="https://cocoapods.org/pods/CNLFoundationTools"><img src="https://img.shields.io/badge/pod-0.0.8-blue.svg" alt="CocoaPods compatible" /></a>

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

Run backgoundClosure async in global queue, then completionClosure async in main queue:
```swift
func asyncGlobal (_ backgroundClosure: @escaping () -> Void, _ completionClosure: @escaping (() -> Void) )
```

Run backgoundClosure async in global queue:
```swift
func asyncGlobal (_ backgroundClosure: @escaping () -> Void)
```

Run backgoundClosure async in global queue, then calls completionClosure async in main queue with result of backgroundClosure:
```swift
func asyncGlobal<R> (_ backgroundClosure: @escaping () -> R, _ completionClosure: @escaping ((_ result: R) -> ()) )
```

Run backgoundClosure sync in main queue:
```swift
func syncMain (_ backgroundClosure: @escaping () -> Void )
```

Run backgoundClosure async in main queue, then calls completionClosure:
```swift
func asyncMain (_ backgroundClosure: @escaping () -> Void, _ completionClosure: @escaping (() -> Void) )
```

Run backgoundClosure async in main queue:
```swift
func asyncMain (_ backgroundClosure: @escaping () -> Void )
```

Run backgoundClosure async in main queue, then calls completionClosure with result of backgroundClosure:
```swift
func asyncMain<R> (_ backgroundClosure: @escaping () -> R, _ completionClosure: @escaping ((_ result: R) -> ()) )
```

## TODO: Update README.md for:
### CNLURLCache
### Int extensions
### Stirng extensions
### Array extensions
### Dictionary extensions
### Date extensions
### TimeZone extensions
### Data extensions
### AttributedString extensions
### Timer extensions

## Author

[Igor Smirnov](https://www.github.com/megavolt605 "Igor Smirnov Github")

## License

CNLFoundationTools is released under [MIT license](https://raw.githubusercontent.com/xmartlabs/XLActionController/master/LICENSE) and copyrighted by Igor Smirnov.
