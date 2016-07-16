//
//  Throttle.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation

class Throttle<T>: NSObject {
    var output: ((T) -> Void)?
    
    // Min date
    var lastFired = NSDate(timeIntervalSinceReferenceDate: 0)
    var interval = 0.2
    var scheduled: NSTimer?
    var scheduledValue: T?
    
    init(interval: Double = 0.2) {
        self.interval = interval
    }
    
    func next(output: (T) -> Void) {
        self.output = output
    }
    
    func invalidate() {
        scheduled?.invalidate()
    }
    
    func input(value: T, date: NSDate? = nil) {
        let date = date ?? NSDate()
        
        let timeDiff = date.timeIntervalSinceDate(lastFired)
        
        // Time is before last fired, abort
        if timeDiff < 0 { return }
        
        // Time is after interval, fire as usual
        if timeDiff > interval {
            if output != nil {
                output!(value)
                return
            }
        }
        
        // Time is before interval, schedule output
        
        // Cancel scheduled, if any
        if scheduled != nil {
            scheduled!.invalidate()
        }
        
        // Schedule output
        scheduledValue = value
        NSTimer.scheduledTimerWithTimeInterval(interval - timeDiff, target: self, selector: #selector(Throttle.fireOutput), userInfo: nil, repeats: false)
    }
    
    func fireOutput() {
        if scheduledValue != nil && output != nil{
            output!(scheduledValue!)
            scheduledValue = nil
        }
    }
}