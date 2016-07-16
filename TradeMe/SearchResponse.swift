//
//  SearchResponse.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchResponse: Mappable {
    
    required init?(_ map: Map) { }
    init() { }
    func mapping(map: Map) {
        totalCount <- map["TotalCount"]
        page <- map["Page"]
        pageSize <- map["PageSize"]
        list <- map["List"]
        didYouMean <- map["DidYouMean"]
        foundCategories <- map["FoundCategories"]
        favouriteId <- map["FavouriteId"]
        favouriteType <- map["FavouriteType"]
        parameters <- map["Parameters"]
        sortOrders <- map["SortOrders"]
    }
    
    var totalCount = 0
    var page = 0
    var pageSize = 0
    var list = [Listing]()
    var didYouMean = ""
    var foundCategories = [FoundCategory]()
    var favouriteId = 0
    var favouriteType: String? // None Category Search AttributeSearch Seller
    var parameters = [SearchParameter]()
    var sortOrders = [AttributeOption]()
    
    // MemberProfile: MemberProfile
}