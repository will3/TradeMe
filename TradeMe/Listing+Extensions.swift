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
    func formatCondition() -> String {
        return isNew ?
            NSLocalizedString("New", comment: "") :
            NSLocalizedString("Used", comment: "")
    }
}

extension ListedItemDetail {
    func formatShippingOptions() -> String {
        return shippingOptions.map { $0.method }.joinWithSeparator("\n")
    }
    
    func formatPaymentOptions() -> String {
        return paymentOptions
            .componentsSeparatedByString(",")
            .map { $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) }
            .joinWithSeparator("\n")
    }
    
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
}