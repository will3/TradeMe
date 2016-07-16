//
//  BidCollection.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

class BidCollection: Mappable {
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
    var list = [Bid]()
}