//
//  Cache.swift
//  TradeMe
//
//  Created by will3 on 15/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import PromiseKit

class PromiseManager {
    var inProgress = [String: Any]()
    
    func dequeue<T>(key: String, promiseFactory: (() -> Promise<T>)) -> Promise<T> {
        if inProgress[key] != nil {
            if let promise = inProgress[key] as? Promise<T> {
                return promise
            }
            
            fatalError("expected Promise of \"\(T.self)\", but got \(inProgress[key])")
        }
        
        let promise = promiseFactory()
        inProgress[key] = promise
        
        // Remove promise from queue
        promise.always {
            self.inProgress[key] = nil
        }
    
        return promise
    }
}