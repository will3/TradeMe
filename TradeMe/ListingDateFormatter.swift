//
//  ListingDateFormatter.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation

/**
 Formatter for listing dates
 */
class ListingDateFormatter {
    /**
     Format end date of a listing
     
     - parameter date: end date of listing
     - returns: a formatted string
     */
    static func formatEndDate(date: NSDate) -> String {
        let interval = date.timeIntervalSinceNow
        if interval > 0 {
            // Future
            let format = NSLocalizedString("Closes: %@", comment: "")
            return String(format: format, formatInterval(interval))
        }
        
        // Past
        return NSLocalizedString("Closed", comment: "")
    }
    
    /**
     Format a time interval
     
     - parameter interval: interval to format
     - returns: a formatted string
     */
    static func formatInterval(interval: NSTimeInterval) -> String {
        if interval > DateConstants.day {
            let format = NSLocalizedString("%li days", comment: "")
            return String(format: format, Int(floor(interval / DateConstants.day)))
        } else if interval > DateConstants.hour {
            let format = NSLocalizedString("%li hrs", comment: "")
            return String(format: format, Int(floor(interval / DateConstants.hour)))
        }
        
        let format = NSLocalizedString("%li mins", comment: "")
        return String(format: format, Int(floor(interval / DateConstants.min)))
    }
}