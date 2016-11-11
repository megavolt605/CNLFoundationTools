//
//  CNDispatch.swift
//  CNFoundationTools
//
//  Created by Igor Smirnov on 11/11/2016.
//  Copyright © 2016 Complex Numbers. All rights reserved.
//

import Foundation

public func asyncGlobal (_ backgroundClosure: @escaping () -> Void, _ completionClosure: @escaping (() -> Void) ) {
    DispatchQueue.global(qos: .default).async {
        backgroundClosure()
        DispatchQueue.main.async {
            completionClosure()
        }
    }
}

public func asyncGlobal (_ backgroundClosure: @escaping () -> Void) {
    DispatchQueue.global(qos: .default).async {
        backgroundClosure()
    }
}

public func asyncGlobal<R> (_ backgroundClosure: @escaping () -> R, _ completionClosure: @escaping ((_ result: R) -> ()) ) {
    DispatchQueue.global(qos: .default).async {
        let res = backgroundClosure()
        DispatchQueue.main.async {
            completionClosure(res)
        }
    }
}

public func syncMain (_ backgroundClosure: @escaping () -> Void ) {
    DispatchQueue.main.sync {
        backgroundClosure()
    }
}

public func asyncMain (_ backgroundClosure: @escaping () -> Void, _ completionClosure: @escaping (() -> Void) ) {
    DispatchQueue.main.async {
        backgroundClosure()
        completionClosure()
    }
}

public func asyncMain (_ backgroundClosure: @escaping () -> Void ) {
    DispatchQueue.main.async {
        backgroundClosure()
    }
}

public func asyncMain<R> (_ backgroundClosure: @escaping () -> R, _ completionClosure: @escaping ((_ result: R) -> ()) ) {
    DispatchQueue.main.async {
        let res = backgroundClosure()
        completionClosure(res)
    }
}
