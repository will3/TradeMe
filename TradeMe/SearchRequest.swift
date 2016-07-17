//
//  SearchRequest.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

enum PhotoSize : String {
    case Thumbnail = "Thumbnail"
    case List = "List"
    case Medium = "Medium"
    case Gallery = "Gallery"
    case Large = "Large"
    case FullSize = "FullSize"
}

enum SortOrder : String {
    case Default = "Default"
    case FeaturedFirst = "FeaturedFirst"
    case SuperGridFeaturedFirst = "SuperGridFeaturedFirst"
    case TitleAsc = "TitleAsc"
    case ExpiryAsc = "ExpiryAsc"
    case ExpiryDesc = "ExpiryDesc"
    case PriceAsc = "PriceAsc"
    case PriceDesc = "PriceDesc"
    case BidsMost = "BidsMost"
    case BuyNowAsc = "BuyNowAsc"
    case BuyNowDesc = "BuyNowDesc"
    case ReviewsDesc = "ReviewsDesc"
    case HighestSalary = "HighestSalary"
    case LowestSalary = "LowestSalary"
    case LowestKilometres = "LowestKilometres"
    case HighestKilometres = "HighestKilometres"
    case NewestVehicle = "NewestVehicle"
    case OldestVehicle = "OldestVehicle"
    case BestMatch = "BestMatch"
}

class SearchRequest: Mappable {
    init() { }
    required init?(_ map: Map) { }
    func mapping(map: Map) {
        buy <- map["buy"]
        category <- map["category"]
        clearance <- map["clearance"]
        condition <- map["condition"]
        date_from <- map["date_from"]
        expired <- map["expired"]
        member_listing <- map["member_listing"]
        page <- map["page"]
        pay <- map["pay"]
        photo_size <- map["photo_size"]
        return_metadata <- map["return_metadata"]
        rows <- map["rows"]
        search_string <- map["search_string"]
        shipping_method <- map["shipping_method"]
        sort_order <- map["sort_order"]
    }
    
    var buy: String? // All BuyNow
    var category: String?
    var clearance: String? // All Clearance OnSale
    var condition: String? // All New Used
    var date_from: NSDate?
    var expired: Bool?
    var member_listing: Int?
    var page: Int?
    var pay: String? // All PayNow
    var photo_size: PhotoSize? // Thumbnail List Medium Gallery Large FullSize
    var return_metadata: Bool?
    var rows: Int?
    var search_string: String?
    var shipping_method: String? // All Free Pickup
    var sort_order: SortOrder?
    
    var user_district: Int?
    var user_region: Int?
}