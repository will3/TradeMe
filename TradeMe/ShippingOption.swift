//
//  ShippingOption.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

class ShippingOption : Mappable {
    required init?(_ map: Map) { }
    init() { }
    func mapping(map: Map) {
        type <- map["Type"]
        price <- map["Price"]
        method <- map["Method"]
        shippingId <- map["ShippingId"]
    }
    
    var type = ""   // None Unknown Undecided Pickup Free Custom
    var price: NSNumber?
    var method = ""
    var shippingId = 0
}