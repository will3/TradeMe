//
//  AllowsPickups.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation

/// Model generated from Trade Me API, for detailed documentation refer to http://developer.trademe.co.nz/
enum AllowsPickups : Int {
    case None = 0   // The listing allows pick up, but does not require it.
    case Allow = 1  // The buyer can pickup if they so choose.
    case Demand = 2 // The buyer must pickup the item.
    case Forbid = 3 // The buyer cannot pickup the item (delivery only).
}