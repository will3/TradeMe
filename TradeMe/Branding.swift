//
//  Branding.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

class Branding: Mappable {
    required init?(_ map: Map) { }
    init() { }
    func mapping(map: Map) {
        largeSquareLogo <- map["LargeSquareLogo"]
        largeWideLogo <- map["LargeWideLogo"]
    }
    
    var largeSquareLogo = ""
    var largeWideLogo = ""
}
