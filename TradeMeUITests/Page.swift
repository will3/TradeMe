//
//  Page.swift
//  TradeMe
//
//  Created by will3 on 18/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import XCTest

protocol Page {
    var viewIdentifier: AccessibilityIdentifiers { get }
}

extension Page {
    func assertPage(app: XCUIApplication) {
        let view = app.otherElements[viewIdentifier.rawValue]
        
        eventually(check: {
            view.exists
        }) { result in
            XCTAssert(result, "could not find view with identifier \(self.viewIdentifier.rawValue)")
        }
    }
    
    func wait(time: Double = 1.0) {
        NSThread.sleepForTimeInterval(time)
    }
}