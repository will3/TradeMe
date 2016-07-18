//
//  SearchParameter.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

/// Model generated from Trade Me API, for detailed documentation refer to http://developer.trademe.co.nz/
class SearchParameter: Mappable {
    required init?(_ map: Map) { }
    init() { }
    func mapping(map: Map) {
        displayName <- map["DisplayName"]
        name <- map["Name"]
        lowerBoundName <- map["LowerBoundName"]
        upperBoundName <- map["UpperBoundName"]
        type <- map["Type"]
        allowsMultipleValues <- map["AllowsMultipleValues"]
        mutualExclusionGroup <- map["MutualExclusionGroup"]
        dependentOn <- map["DependentOn"]
        externalOptionsKey <- map["ExternalOptionsKey"]
        options <- map["Options"]
    }
    
    var displayName = ""
    var name = ""
    var lowerBoundName = ""
    var upperBoundName = ""
    var type: String? // Boolean Numeric String PropertyRegionId PropertyDistrictId PropertySuburbId var location
    var allowsMultipleValues = false
    var mutualExclusionGroup = ""
    var dependentOn = ""
    var externalOptionsKey = ""
    var options = [AttributeOption] ()
}