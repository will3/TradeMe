//
//  Throttle.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation

/**
 Used to limit fequency of input, such as search bar typing
 */
class Throttle<T>: NSObject {
    /// Output block
    var nextBlock: ((T) -> Void)?
    
    /// Last fire set to min date
    var lastFired = NSDate(timeIntervalSinceReferenceDate: 0)
    
    /// Interval
    var interval = 0.2
    
    /// Scheduled timer
    private var scheduled: NSTimer?
    
    /// Value scheduled
    private var scheduledValue: T?
    
    /// Fired date scheduled
    private var scheduledDate: NSDate?
    
    /**
     Creates a throttle
     
     Example:
     ```
     let throttle = Throttle<String>(0.2).next { text in
        // Do something with text
     }
     // "a" will fire next block straight away
     throttle.input("a")
     // "b" will fire after 0.2 seconds
     throttle.input("b")
     ```
     
     - parameter interval: min seconds between signals
     */
    init(_ interval: Double = 0.2) {
        self.interval = interval
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
                lastFired = date
                return
            }
        }
        
        // Time is before interval, schedule output
        
        // Cancel scheduled, if any
        if scheduled != nil {
            scheduled!.invalidate()
        }
        
        // Schedule output
        let delay = interval - timeDiff
        scheduledValue = value
        scheduledDate = date.dateByAddingTimeInterval(delay)
        NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: #selector(Throttle.fireOutput), userInfo: nil, repeats: false)
    }
    
    /**
     Fire output, used internally by timers
     */
    func fireOutput() {
        if scheduledValue != nil && nextBlock != nil && scheduledDate != nil{
            nextBlock!(scheduledValue!)
            lastFired = scheduledDate!
            
            scheduledValue = nil
            scheduledDate = nil
        }
    }
}