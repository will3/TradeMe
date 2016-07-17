//
//  Throttle.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation

/**
 Throttle signals
 */
class Throttle<T>: NSObject {
    // Output block
    var nextBlock: ((T) -> Void)?
    
    // Last fire set to min date
    var lastFired = NSDate(timeIntervalSinceReferenceDate: 0)
    
    // Interval
    var interval = 0.2
    
    // Scheduled timer
    private var scheduled: NSTimer?
    
    // Value scheduled
    private var scheduledValue: T?
    
    init(interval: Double = 0.2, start: NSDate? = nil) {
        self.interval = interval
        if start != nil {
            lastFired = start!
        }
    }
    
    /**
     Set a listener for the signal, only one listener is supported at a time
     
     - parameter block: Listener for signal
     - returns: Self for chainability
     */
    func next(block: (T) -> Void) -> Self {
        self.nextBlock = block
        return self
    }
    
    /**
     Invalidate any signals scheduled
     */
    func invalidate() {
        scheduled?.invalidate()
    }
    
    /**
     Input a value
     
     - parameter value: value
     - parameter date: date of signal, optional, use "now" if empty
     */
    func input(value: T, date: NSDate? = nil) {
        let date = date ?? NSDate()
        
        let timeDiff = date.timeIntervalSinceDate(lastFired)
        
        // Time is before last fired, abort
        if timeDiff < 0 { return }
        
        // Time is after interval, fire as usual
        if timeDiff > interval {
            if nextBlock != nil {
                nextBlock!(value)
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
    
    /**
     Fire output, used internally by timers
     */
    func fireOutput() {
        if scheduledValue != nil && nextBlock != nil{
            nextBlock!(scheduledValue!)
            scheduledValue = nil
        }
    }
}