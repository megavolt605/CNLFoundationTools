//
//  CNLDeepLink.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 18/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

/// Deep link parameter
public struct CNLDeepLinkParameters {
    public var parameters: [(name: String, value: String?)] = []
    
    public subscript (name: String) -> String? {
        return parameters.filter { return $0.name == name }.first?.value
    }
    
    public subscript (name: String) -> Int? {
        return parameters.filter { return $0.name == name }.first?.value?.toInt
    }
    
    public func exists(_ name: String) -> Bool {
        return parameters.filter { return $0.name == name }.count != 0
    }
}

/// Components of deep link
public struct CNLDeepLinkComponents {
    public var scheme: String
    public var host: String
    public var path: String?
    public var parameters: CNLDeepLinkParameters
}

/// Decompose deep link into scheme name, link name and parameters array
///
/// Usage:
/// let url = URL(string: "myapp://host/path?param1=123&param2=abc")!
/// if let deepLinkComponents = CNLDeepLink.parseURL(url) {
///     print(deepLinkComponents.scheme)
///     print(deepLinkComponents.host)
///     print(deepLinkComponents.path)
///     if let param: Int = deepLinkComponents.parameters["param1"] {
///         print(param)
///     }
///     if let param: String = deepLinkComponents.parameters["param2"] {
///         print(param)
///     }
/// }
public struct CNLDeepLink {
    public static func parseURL(_ url: URL) -> CNLDeepLinkComponents? {
        var parameters = CNLDeepLinkParameters()
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let urlParameters = urlComponents?.queryItems {
            parameters.parameters = urlParameters.map { (name: $0.name, value: $0.value) }
        }
        if let scheme = urlComponents?.scheme, let host = urlComponents?.host, let path = urlComponents?.path {
            return CNLDeepLinkComponents(scheme: scheme, host: host, path: path, parameters: parameters)
        }
        return nil
    }
}
