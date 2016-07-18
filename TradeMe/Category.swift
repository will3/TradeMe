//
//  Category.swift
//  TradeMe
//
//  Created by will3 on 15/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

/// Model generated from Trade Me API, for detailed documentation refer to http://developer.trademe.co.nz/
class Category: Mappable {
    
    var name = ""
    var number = ""
    var path = ""
    var subcategories = [Category]()
    var count = 0
    var hasClassifieds = false
    
    required init?(_ map: Map) { }

    init() { }
    
    func mapping(map: Map) {
        name    <-  map["Name"]
        number  <-  map["Number"]
        path    <-  map["Path"]
        subcategories   <-  map["Subcategories"]
        count <- map["Count"]
        hasClassifieds <- map["HasClassifieds"]
    }
    
    // MARK: Not part of API
    
    var isRoot = false
}