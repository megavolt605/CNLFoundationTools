# CNFoundationTools
Basic tools and extensions for Foundation framework

<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
<a href="https://cocoapods.org/pods/CNFoundationTools"><img src="https://img.shields.io/badge/pod-0.0.1-blue.svg" alt="CocoaPods compatible" /></a>

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects.

Specify CNFoundationTools into your project's Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'CNFoundationTools'
```

## Usage

### CNAssociated
```swift
fileprivate var variableKey = "variableKey"
extension UIView
    var "variable": "type" {
        get {
            if let value = (objc_getAssociatedObject(self, &variableKey) as? CNAssociated<"type">)?.closure {
                return value
            } else {
                return "defaultValue"
            }
        }
        set {
            objc_setAssociatedObject(self, &variableKey, CNAssociated<"type">(closure: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
end
```

For example, following code will add `stringTag` variable of type `String` to all `UIView` and it descedants:

```swift
fileprivate var UIKitStringTag = "UIKitStringTag"
extension UIView
    var stringTag: String? {
        get {
            if let value = (objc_getAssociatedObject(self, &UIKitStringTag) as? CNAssociated<String?>)?.closure {
                return value
            } else {
                return nil
            }
        }
        set {
            objc_setAssociatedObject(self, &UIKitStringTag, CNAssociated<String?>(closure: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
end
``` 

## Author

[Igor Smirnov](https://www.github.com/megavolt605 "Igor Smirnov Github")

## License

CNFoundationTools is released under [MIT license](https://raw.githubusercontent.com/xmartlabs/XLActionController/master/LICENSE) and copyrighted by Igor Smirnov.
