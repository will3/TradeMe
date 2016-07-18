//
//  ListingDateFormatterTests.swift
//  TradeMe
//
//  Created by will3 on 18/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import XCTest
import Nimble
@testable import TradeMe

class ListingDateFormatterTests: XCTestCase {
    func testFormatMins() {
        let interval = NSTimeInterval(60 * 3 * 1000.0 + 1)
        expect(ListingDateFormatter.formatInterval(interval)).to(equal("3 mins"))
    }
    
    func testFormatHours() {
        let interval = NSTimeInterval(60 * 60 * 2 * 1000.0 + 1)
        expect(ListingDateFormatter.formatInterval(interval)).to(equal("2 hrs"))
    }
    
    func testFormatDays() {
        let interval = NSTimeInterval(24 * 60 * 60 * 4 * 1000.0 + 1)
        expect(ListingDateFormatter.formatInterval(interval)).to(equal("4 days"))
    }
    
    func testFormatEndDateFuture() {
        let date = NSDate().dateByAddingTimeInterval(60 * 60 * 2 * 1000.0 + 1)
        expect(ListingDateFormatter.formatEndDate(date)).to(equal("Closes: 2 hrs"))
    }
    
    func testFormatEndDatePast() {
        let date = NSDate().dateByAddingTimeInterval(-60 * 60 * 2 * 1000.0)
        expect(ListingDateFormatter.formatEndDate(date)).to(equal("Closed"))
    }
}

//class ListingDateFormatter {
//    static func formatEndDate(date: NSDate) -> String {
//        let interval = date.timeIntervalSinceNow
//        if interval > 0 {
//            // Future
//            let format = NSLocalizedString("Closes: %@", comment: "")
//            return String(format: format, formatInterval(interval))
//        }
//        
//        // Past
//        return NSLocalizedString("Closed", comment: "")
//    }
//    
//    static func formatInterval(interval: NSTimeInterval) -> String {
//        if interval > DateConstants.day {
//            let format = NSLocalizedString("%li days", comment: "")
//            return String(format: format, Int(ceil(interval / DateConstants.day)))
//        } else if interval > DateConstants.hour {
//            let format = NSLocalizedString("%li hrs", comment: "")
//            return String(format: format, Int(ceil(interval / DateConstants.hour)))
//        }
//        
//        let format = NSLocalizedString("%li mins", comment: "")
//        return String(format: format, Int(ceil(interval / DateConstants.min)))
//    }
//}