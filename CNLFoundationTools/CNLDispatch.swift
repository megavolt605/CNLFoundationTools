//
//  CNLDispatch.swift
//  CNLFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation


/// Run backgoundClosure async in global queue, then completionClosure async in main queue
///
/// - Parameters:
///   - backgroundClosure: payload closure
///   - completionClosure: completion closure
public func asyncGlobal (_ backgroundClosure: @escaping () -> Void, _ completionClosure: @escaping (() -> Void) ) {
    DispatchQueue.global(qos: .default).async {
        backgroundClosure()
        DispatchQueue.main.async {
            completionClosure()
        }
    }
}

/// Run backgoundClosure async in global queue
///
/// - Parameters:
///   - backgroundClosure: payload closure
public func asyncGlobal (_ backgroundClosure: @escaping () -> Void) {
    DispatchQueue.global(qos: .default).async {
        backgroundClosure()
    }
}

/// Run backgoundClosure async in global queue, then calls completionClosure async in main queue with result of backgroundClosure
///
/// - Parameters:
///   - backgroundClosure: payload closure with result
///   - completionClosure: completion closure with parameter
public func asyncGlobal<R> (_ backgroundClosure: @escaping () -> R, _ completionClosure: @escaping ((_ result: R) -> ()) ) {
    DispatchQueue.global(qos: .default).async {
        let res = backgroundClosure()
        DispatchQueue.main.async {
            completionClosure(res)
        }
    }
}

/// Run backgoundClosure sync in main queue
///
/// - Parameter backgroundClosure: <#backgroundClosure description#>
public func syncMain (_ backgroundClosure: @escaping () -> Void ) {
    DispatchQueue.main.sync {
        backgroundClosure()
    }
}

/// Run backgoundClosure async in main queue, then calls completionClosure
///
/// - Parameters:
///   - backgroundClosure: payload closure
///   - completionClosure: completion closure
public func asyncMain (_ backgroundClosure: @escaping () -> Void, _ completionClosure: @escaping (() -> Void) ) {
    DispatchQueue.main.async {
        backgroundClosure()
        completionClosure()
    }
}

/// Run backgoundClosure async in main queue
///
/// - Parameters:
///   - backgroundClosure: payload closure
public func asyncMain (_ backgroundClosure: @escaping () -> Void ) {
    DispatchQueue.main.async {
        backgroundClosure()
    }
}

/// Run backgoundClosure async in main queue, then calls completionClosure with result of backgroundClosure
///
/// - Parameters:
///   - backgroundClosure: payload closure with result
///   - completionClosure: completion closure with parameter
public func asyncMain<R> (_ backgroundClosure: @escaping () -> R, _ completionClosure: @escaping ((_ result: R) -> ()) ) {
    DispatchQueue.main.async {
        let res = backgroundClosure()
        completionClosure(res)
    }
}
