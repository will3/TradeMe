//
//  GetListingDetailRequest.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

/// Model generated from Trade Me API, for detailed documentation refer to http://developer.trademe.co.nz/
class GetListingDetailRequest: Mappable {
    required init?(_ map: Map) { }
    init() { }
    func mapping(map: Map) {
        increment_view_count <- map["increment_view_count"]
        question_limit <- map["question_limit"]
        return_member_profile <- map["return_member_profile"]
    }
    
    var listingId = 0
    var file_format = "json"
    
    var increment_view_count: Bool?
    var question_limit: Int?
    var return_member_profile: Int?
}