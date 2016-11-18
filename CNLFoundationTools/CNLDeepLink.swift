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
    public var link: String
    public var parameters: CNLDeepLinkParameters
}

/// Decompose deep link into scheme name, link name and parameters array
public struct CNLDeepLink {
    public static func parseURL(url: URL) -> CNLDeepLinkComponents? {
        var parameters = CNLDeepLinkParameters()
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let urlParameters = urlComponents?.queryItems {
            parameters.parameters = urlParameters.map { (name: $0.name, value: $0.value) }
        }
        if let scheme = urlComponents?.scheme, let host = urlComponents?.host {
            return CNLDeepLinkComponents(scheme: scheme, link: host, parameters: parameters)
        }
        return nil
    }
}
