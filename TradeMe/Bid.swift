//
//  Bid.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

/// Model generated from Trade Me API, for detailed documentation refer to http://developer.trademe.co.nz/
class Bid: Mappable {
    required init?(_ map: Map) { }
    init() { }
    func mapping(map: Map) {
        account <- map["Account"]
        bidAmount <- map["BidAmount"]
        isByMobile <- map["IsByMobile"]
        isByProxy <- map["IsByProxy"]
        bidDate <- map["BidDate"]
        isBuyNow <- map["IsBuyNow"]
    }
    
    var account = ""
    var bidAmount: NSNumber?
    var isByMobile = false
    var isByProxy = false
    var bidDate: NSDate?
    var isBuyNow = false
    
    // Member not implemented
    // var Bidder: Member?
}