//
//  AttributeOption.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

/// Model generated from Trade Me API, for detailed documentation refer to http://developer.trademe.co.nz/
class AttributeOption: Mappable {
    required init?(_ map: Map) { }
    init() { }
    func mapping(map: Map) {
        value <- map["Value"]
        display <- map["Display"]
    }
    
    var value = ""
    var display = ""
}