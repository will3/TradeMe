//
//  Attribute.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

/// Model generated from Trade Me API, for detailed documentation refer to http://developer.trademe.co.nz/
class Attribute: Mappable {
    required init?(_ map: Map) { }
    init() { }
    func mapping(map: Map) {
        name <- map["Name"]
        displayName <- map["DisplayName"]
        value <- map["Value"]
        type <- map["Type"]
        range <- map["Range"]
        options <- map["Options"]
        isRequiredForSell <- map["IsRequiredForSell"]
    }
    
    var name = ""
    var displayName = ""
    var value = ""
    var type = "" // None Boolean Integer Decimal String DateTime
    var range: AttributeRange?
    var options = [AttributeOption]()
    var isRequiredForSell = false
}