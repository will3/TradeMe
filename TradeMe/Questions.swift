//
//  Questions.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

/// Model generated from Trade Me API, for detailed documentation refer to http://developer.trademe.co.nz/
class Questions: Mappable {
    required init?(_ map: Map) { }
    init() { }
    func mapping(map: Map) {
        totalCount <- map["TotalCount"]
        page <- map["Page"]
        pageSize <- map["PageSize"]
        list <- map["List"]
    }
    
    var totalCount = 0
    var page = 0
    var pageSize = 0
    var list = [Question]()
}