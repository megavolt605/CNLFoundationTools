//
//  CNLURLCache.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 12/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

public final class CNLURLCache: URLCache {
    
    var cacheExpired: TimeInterval = 24.0 * 60.0 * 60.0
    
    var ignoredPrefixes: [String] = []
    
    // UserInfo expires key
    static var ExpiresKey = "CNLURLCache";
    
    // get cache response for a request
    override public func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        // create empty response
        
        if let url = request.url?.absoluteString {
            if (ignoredPrefixes.filter { return url.contains($0) }).count != 0 {
                return nil
            }
        }
        
        var response: CachedURLResponse? = nil
        
        // try to get cache response, userInfo and cache date
        if let cachedResponse = super.cachedResponse(for: request), let userInfo = cachedResponse.userInfo, let cacheDate = userInfo[CNLURLCache.ExpiresKey] as? Date {
            // check if the cache data are expired
            if (cacheDate.timeIntervalSinceNow < -cacheExpired) {
                // remove old cache request
                self.removeCachedResponse(for: request);
            } else {
                // the cache request is still valid
                response = cachedResponse
            }
        }
        
        return response
    }
    
    // store cached response
    override public func storeCachedResponse(_ cachedResponse: CachedURLResponse, for forRequest: URLRequest) {

        // create userInfo dictionary
        var userInfo = cachedResponse.userInfo ?? [:]

        // add current date to the UserInfo
        userInfo[CNLURLCache.ExpiresKey] = Date()
        
        // create new cached response
        let newCachedResponse = CachedURLResponse(
            response: cachedResponse.response,
            data: cachedResponse.data,
            userInfo: userInfo,
            storagePolicy: cachedResponse.storagePolicy
        )
        super.storeCachedResponse(newCachedResponse, for: forRequest)
    }
    
}
