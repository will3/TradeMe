//
//  PhotoUrl.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

/// Model generated from Trade Me API, for detailed documentation refer to http://developer.trademe.co.nz/
class PhotoUrl : Mappable {
    required init?(_ map: Map) { }
    init() { }
    func mapping(map: Map) {
        thumbnail <- map["Thumbnail"]
        medium <- map["Medium"]
        gallery <- map["Gallery"]
        large <- map["Large"]
        fullSize <- map["FullSize"]
        plusSize <- map["PlusSize"]
        photoId <- map["PhotoId"]
        originalWidth <- map["OriginalWidth"]
        originalHeight <- map["OriginalHeight"]
    }
    
    var thumbnail = ""
    var medium = ""
    var gallery = ""
    var large = ""
    var fullSize = ""
    var plusSize = ""
    var photoId = 0
    var originalWidth = 0
    var originalHeight = 0
}