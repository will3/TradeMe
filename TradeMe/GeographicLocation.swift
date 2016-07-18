//
//  GeographicLocation.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

/// Model generated from Trade Me API, for detailed documentation refer to http://developer.trademe.co.nz/
class GeographicLocation: Mappable {
    required init?(_ map: Map) { }
    init() { }
    func mapping(map: Map) {
        latitude <- map["Latitude"]
        longitude <- map["Longitude"]
        northing <- map["Northing"]
        easting <- map["Easting"]
        accuracy <- map["Accuracy"]
    }
    
    var latitude = 0.0
    var longitude = 0.0
    var northing = 0
    var easting = 0
    var accuracy: String? // None Address Street Suburb
}