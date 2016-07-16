//
//  GetCategoryRequest.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

class GetCategoryRequest: Mappable {
    var number = "0"
    var fileFormat = "json"
    var depth: Int?
    var region: Int?
    var withCounts: Bool?
    
    init() { }
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        depth       <- map["depth"]
        region      <- map["region"]
        withCounts  <- (map["with_counts"], BoolTransform())
    }
}