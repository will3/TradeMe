//
//  ReserveState.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation

/// Model generated from Trade Me API, for detailed documentation refer to http://developer.trademe.co.nz/
enum ReserveState: Int {
    // There is no reserve on the item (i.e. the reserve price is the same as the starting price).
    case None = 0
    // The value of the highest bid has exceeded the reserve price.
    case Met = 1
    // The value of the highest bid has not reached the reserve price.
    case NotMet = 2
    // The listing cannot have a reserve because bidding is not allowed. This may be because it is a classified or because it is a Buy Now Only auction.
    case NotApplicable = 3
}