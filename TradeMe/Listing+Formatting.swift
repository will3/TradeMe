//
//  ListingFormatter.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit

extension Listing {
    // Format |isNew
    func formatCondition() -> String {
        return isNew ?
            NSLocalizedString("New", comment: "") :
            NSLocalizedString("Used", comment: "")
    }
    
    // Format |reserveState
    func formatReserveState() -> String {
        switch reserveState {
        case .None:
            return NSLocalizedString("No reserve", comment: "")
        case .Met:
            return NSLocalizedString("Reserve met", comment: "")
        case .NotMet:
            return NSLocalizedString("Reserve not met", comment: "")
        case .NotApplicable:
            return ""
        }
    }
}

typealias ListingDetail = (title: String, detail: String)

extension ListedItemDetail {
    // Format |shippingOptions
    func formatShippingOptions() -> String {
        return shippingOptions.map { $0.method }.joinWithSeparator("\n")
    }
    
    // Format |paymentOptions
    func formatPaymentOptions() -> String {
        return paymentOptions
            .componentsSeparatedByString(",")
            .map { $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) }
            .joinWithSeparator("\n")
    }
    
    // Format |allowsPickups
    func formatPickups() -> String {
        switch allowsPickups {
        case .None:
            return NSLocalizedString("Available", comment: "")
        case .Allow:
            return NSLocalizedString("Available", comment: "")
        case .Demand:
            return NSLocalizedString("Must Pickup", comment: "")
        case .Forbid:
            return NSLocalizedString("None", comment: "")
        }
    }
    
    /**
     Format a list of details
     
     - returns: list of (title, detail)
     */
    func getDetails() -> [ListingDetail] {
        var list = [ListingDetail]()
        
        list.append((
            title: NSLocalizedString("Condition", comment: ""),
            detail: formatCondition())
        )
        
        if !body.isEmpty {
            list.append((
                title: NSLocalizedString("Description", comment: ""),
                detail: body))
        }
        
        if shippingOptions.count > 0 {
            list.append((
                title: NSLocalizedString("Shipping", comment: ""),
                detail: formatShippingOptions()))
        }
        
        if !paymentOptions.isEmpty {
            list.append((
                title: NSLocalizedString("Payment", comment: ""),
                detail: formatPaymentOptions()))
        }
        
        list.append((
            title: NSLocalizedString("Pickups", comment: ""),
            detail: formatPickups()))
        
        return list
    }
}