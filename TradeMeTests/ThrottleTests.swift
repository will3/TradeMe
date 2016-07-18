//
//  ThrottleTests.swift
//  TradeMe
//
//  Created by will3 on 18/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import XCTest
import Nimble
@testable import TradeMe

class ThrottleTests: XCTestCase {
    let implicitWait = 0.05
    
    func test_signal_true() {
        var outputs = [String]()
        let throttle = Throttle<String>().next { text in
            outputs.append(text)
        }
        
        throttle.input("foo")
        
        expect(outputs).to(equal(["foo"]))
    }
    
    func test_signal_true_false() {
        var outputs = [String]()
        let throttle = Throttle<String>().next { text in
            outputs.append(text)
        }
        
        throttle.input("foo")
        throttle.input("foo2")
        
        expect(outputs).to(equal(["foo"]))
    }
    
    func test_signal_true_true() {
        var outputs = [String]()
        let throttle = Throttle<String>(0.2).next { text in
            outputs.append(text)
        }
        
        let date = NSDate()
        // Schedule second signal so it's after interval
        let date2 = date.dateByAddingTimeInterval(0.3 * 1000.0)
        
        throttle.input("foo", date: date)
        throttle.input("foo2", date: date2)
        
        expect(outputs).to(equal(["foo", "foo2"]))
    }
    
    func test_signal_true_false_true() {
        var outputs = [String]()
        let throttle = Throttle<String>(0.2).next { text in
            outputs.append(text)
        }
        
        let date = NSDate()
        // Schedule second signal so it's after interval
        let date2 = date.dateByAddingTimeInterval(0.3 * 1000.0)
        
        throttle.input("foo", date: date)
        // This one should be ignored
        throttle.input("foo2", date: date)
        throttle.input("foo3", date: date2)
        
        expect(outputs).to(equal(["foo", "foo3"]))
    }
}