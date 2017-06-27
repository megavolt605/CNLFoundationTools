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
    /// Known parameters
    public var parameters: [(name: String, value: String?)] = []
    
    /// Returns String parameter by its name
    ///
    /// - Parameter name: Parameter name
    public subscript (name: String) -> String? {
        return parameters.filter { return $0.name == name }.first?.value
    }
    
    /// Returns Int parameter by its name
    ///
    /// - Parameter name: Parameter name
    public subscript (name: String) -> Int? {
        return parameters.filter { return $0.name == name }.first?.value?.toInt
    }
    
    /// Check parameter existance
    ///
    /// - Parameter name: Parameter name
    public func exists(_ name: String) -> Bool {
        return parameters.filter { return $0.name == name }.count != 0
    }
}

/// Components of deep link
public struct CNLDeepLinkComponents {
    /// Deep link scheme
    public var scheme: String
    /// Deep link host
    public var host: String
    /// Deep link path (Optional)
    public var path: String?
    /// Deep link parameters
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
    /// Parse URL and creates CNLDeepLinkComponents struct
    ///
    /// - Parameter url: Source url
    /// - Returns: Result CNLDeepLinkComponents struct
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
