//
//  OpenHome.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

class OpenHome: Mappable {
    required init?(_ map: Map) { }
    init() { }
    func mapping(map: Map) {
        start <- map["Start"]
        end <- map["End"]
    }
    
    var start: NSDate?
    var end: NSDate?
}