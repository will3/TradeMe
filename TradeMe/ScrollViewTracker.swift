//
//  ScrollViewTracker.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit

class ScrollViewTracker {
    
    var lastY = CGFloat(0.0)
    var runningSpeed = CGFloat(0.0)
    var runningSpeedDamping = CGFloat(0.8)
    var maxSpeed = CGFloat(12.0)
    var minSpeed = CGFloat(-12.0)
    
    var didScrollUp: ((UIScrollView) -> Void)?
    var didScrollDown: ((UIScrollView) -> Void)?
    
    func onScrollUp(block: ((UIScrollView) -> Void)) -> Self {
        didScrollUp = block
        return self
    }
    
    func onScrollDown(block: ((UIScrollView) -> Void)) -> Self {
        didScrollDown = block
        return self
    }
    
    func forwardScrollViewDidScroll(scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        if y < 0 ||
            y > scrollView.contentSize.height - scrollView.frame.height{
            // Ignore bouncing from top / bottom edges
            lastY = y
            return
        }
        
        let diff = lastY - y
        
        runningSpeed += diff
        runningSpeed *= runningSpeedDamping
        
        lastY = y
        
        if runningSpeed > maxSpeed {
            if didScrollUp != nil {
                didScrollUp!(scrollView)
            }
        } else if runningSpeed < minSpeed {
            if didScrollDown != nil {
                didScrollDown!(scrollView)
            }
        }
    }
}
