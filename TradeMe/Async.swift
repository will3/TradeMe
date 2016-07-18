//
//  Functions.swift
//  TradeMe
//
//  Created by will3 on 18/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation

/**
 Delays the execution of a block
 
 Runs block in main thread
 
 - parameter delay: number of seconds to wait
 - parameter closure: block to run after delay
 */
func delay(delay: Double, closure: () -> ()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

/**
 Checks for a condition repeatly, either resolve it if it becomes true within timeout, or fail it
 
 - parameter timeout: time out to use
 - parameter check: condition to check
 - parameter closure: passes true condition resolves, false if time out
 */
func eventually(timeout: NSTimeInterval = 2.0, check: () -> Bool, closure: (Bool) -> Void ) {
    var elapsed = 0.0
    let interval = 0.2
    
    while(true) {
        let result = check()
        if result {
            // Matching
            closure(true)
            break
        } else {
            if elapsed >= timeout {
                closure(false)
                break
            }
            check()
            elapsed += interval
        }

        NSThread .sleepForTimeInterval(interval)
    }
}