//
//  Cache.swift
//  TradeMe
//
//  Created by will3 on 15/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import PromiseKit

/**
 Solve issue of same call fired multiple times,
 Promise manager consolidate same requests to one call, and fire multiple 'then' blocks when it finishes
 */
class PromiseManager: NSObject {
    private var inProgress = [String: Any]()
    
    func get<T>(key: String, promiseFactory: (() -> Promise<T>)) -> Promise<T> {
        if inProgress[key] != nil {
            if let promise = inProgress[key] as? Promise<T> {
                return promise
            }
            
            fatalError("expected Promise of \"\(T.self)\", but got \(inProgress[key])")
        }
        
        let promise = promiseFactory()
        inProgress[key] = promise
        
        // Remove promise from inProgress, eventually
        promise.always {
            self.inProgress[key] = nil
        }
    
        return promise
    }
}