//
//  StandardDateTransformTests.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import XCTest
import Nimble
@testable import TradeMe

class StandardDateTransformTests: XCTestCase {
    
    func testSerialize() {
        // 2012-01-01T00:00:00Z
        let date = StandardDateTransform().transformFromJSON("2012-01-01T00:00:00Z")!
        expect(date.timeIntervalSince1970).to(equal(1325329200.0))
    }
    
    func testDeserialize() {
        let date = NSDate(timeIntervalSince1970: 1325329200.0)
        let json = StandardDateTransform().transformToJSON(date)!
        expect(json).to(equal("2012-01-01T00:00:00Z"))
    }
    
}