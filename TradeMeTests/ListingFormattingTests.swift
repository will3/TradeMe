//
//  ListingFormattingTests.swift
//  TradeMe
//
//  Created by will3 on 18/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation

import XCTest
import Nimble
@testable import TradeMe

class ListingFormattingTests: XCTestCase {
    func testFormatCondition() {
        let listing = Listing()
        listing.isNew = false
        expect(listing.formatCondition()).to(equal("Used"))
        listing.isNew = true
        expect(listing.formatCondition()).to(equal("New"))
    }
    
    func testFormatReserveState() {
        let expectations: [ReserveState: String] = [
            .None: "No reserve",
            .Met: "Reserve met",
            .NotMet: "Reserve not met",
            .NotApplicable: ""
        ]
        
        let states: [ReserveState] = [.None, .Met, .NotMet, .NotApplicable]
        let listing = Listing()
        for state in states {
            listing.reserveState = state
            expect(listing.formatReserveState()).to(equal(expectations[state]))
        }
    }
}