//
//  Photo.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

/// Model generated from Trade Me API, for detailed documentation refer to http://developer.trademe.co.nz/
class Photo : Mappable {
    required init?(_ map: Map) { }
    init() { }
    func mapping(map: Map) {
        photoId <- map["PhotoId"]
        value <- map["Value"]
    }
    
    var photoId = 0
    var value: PhotoUrl?
}