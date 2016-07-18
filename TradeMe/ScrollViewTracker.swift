//
//  ScrollViewTracker.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit


/// ScrollView Events
enum ScrollViewEvents {
    /// Nothing interesting happening
    case Default
    /// User seems to be swiping up
    case SwipeUp
    /// User seems to be swiping down
    case SwipeDown
    /// Scroll view bounced from top
    case BounceTop
    /// Scroll view bounced from bottom
    case BounceBottom
}


/// Track scroll view for events
class ScrollViewTracker {
    /// Listener block for events
    typealias Listener = ((UIScrollView) -> Void)
    
    /// Max speed for "swipe up"
    var maxSpeed = CGFloat(24.0)
    
    /// Min speed for "swipe down"
    var minSpeed = CGFloat(-24.0)
    
    /// Last y
    private var lastY = CGFloat(0.0)
    
    /// Running speed
    private var runningSpeed = CGFloat(0.0)
    
    /// Damping for running speed
    private var runningSpeedDamping = CGFloat(0.5)
    
    /// Listenrs by events
    private var listeners = [ScrollViewEvents: Listener]()
    
    /// If true, all movement tracking is paused
    private var locked = false
    
    /**
     Sets a listener for scroll view event
     
     Note only one listener can be attached for each event type
     
     - parameter event: event to listen to
     - parameter block: listener
     - returns: self for chainability
     */
    func on(event: ScrollViewEvents, block: Listener) -> Self {
        listeners[event] = block
        return self
    }
    
    /**
     Lock tracking
     
     All scrolling will be ignored
     
     - parameter flag: false to unlock
     */
    func lock(flag: Bool) {
        locked = flag
    }
    
    /**
     This method should be called at UIScrollViewDelegate.scrollViewDidScroll to forward that event
     
     - parameter scrollView: scroll view to track
     */
    func forwardScrollViewDidScroll(scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        if locked {
            lastY = y
            return
        }
        
        let speed = lastY - y
        
        if y < 0 {
            notify(event: .BounceTop, scrollView: scrollView)
            lastY = y
            return
        }
        
        if y > scrollView.contentSize.height - scrollView.frame.height {
            notify(event: .BounceBottom, scrollView: scrollView)
            lastY = y
            return
        }
        
        runningSpeed += speed
        runningSpeed *= runningSpeedDamping
        
        lastY = y
        
        if runningSpeed > maxSpeed {
            notify(event: .SwipeUp, scrollView: scrollView)
        } else if runningSpeed < minSpeed {
            notify(event: .SwipeDown, scrollView: scrollView)
        } else {
            notify(event: .Default, scrollView: scrollView)
        }
    }
    
    /**
     Invoke listeners when an event has been raised
     
     - parameter event: event to fire
     - scrollView: scrollView the event originated from
     */
    private func notify(event event: ScrollViewEvents, scrollView: UIScrollView) {
        // Notify
        listeners[event]?(scrollView)
    }
}
