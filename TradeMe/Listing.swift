//
//  Listing.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

/// Model generated from Trade Me API, for detailed documentation refer to http://developer.trademe.co.nz/
class Listing : Mappable {
    required init?(_ map: Map) { }
    init() { }
    func mapping(map: Map) {
        listingId <- map["ListingId"]
        title <- map["Title"]
        category <- map["Category"]
        startPrice <- map["StartPrice"]
        buyNowPrice <- map["BuyNowPrice"]
        startDate <- (map["StartDate"], StandardDateTransform())
        // The date the listing will end.
        endDate <- (map["EndDate"], StandardDateTransform())
        isFeatured <- map["IsFeatured"]
        hasGallery <- map["HasGallery"]
        isBold <- map["IsBold"]
        isHighlighted <- map["IsHighlighted"]
        hasHomePageFeature <- map["HasHomePageFeature"]
        maxBidAmount <- map["MaxBidAmount"]
        asAt <- map["AsAt"]
        categoryPath <- map["CategoryPath"]
        pictureHref <- map["PictureHref"]
        hasPayNow <- map["HasPayNow"]
        isNew <- map["IsNew"]
        regionId <- map["RegionId"]
        region <- map["Region"]
        suburbId <- map["SuburbId"]
        suburb <- map["Suburb"]
        bidCount <- map["BidCount"]
        isReserveMet <- map["IsReserveMet"]
        hasReserve <- map["HasReserve"]
        hasBuyNow <- map["HasBuyNow"]
        noteDate <- map["NoteDate"]
        reserveState <- map["ReserveState"]
        isClassified <- map["IsClassified"]
        openHomes <- map["OpenHomes"]
        subtitle <- map["Subtitle"]
        isBuyNowOnly <- map["IsBuyNowOnly"]
        remainingGalleryPlusRelists <- map["RemainingGalleryPlusRelists"]
        isOnWatchList <- map["IsOnWatchList"]
        geographicLocation <- map["GeographicLocation"]
        priceDisplay <- map["PriceDisplay"]
        totalReviewCount <- map["TotalReviewCount"]
        positiveReviewCount <- map["PositiveReviewCount"]
        hasFreeShipping <- map["HasFreeShipping"]
        isClearance <- map["IsClearance"]
        wasPrice <- map["WasPrice"]
        percentageOff <- map["PercentageOff"]
        branding <- map["Branding"]
        isSuperFeatured <- map["IsSuperFeatured"]
    }
    
    var listingId = 0
    var title = ""
    var category = ""
    var startPrice = 0.0
    var buyNowPrice = 0.0
    var startDate: NSDate?
    var endDate: NSDate?
    var isFeatured = false
    var hasGallery = false
    var isBold = false
    var isHighlighted = false
    var hasHomePageFeature = false
    var maxBidAmount = 0
    var asAt: NSDate?
    var categoryPath = ""
    var pictureHref = ""
    var hasPayNow = false
    var isNew = false
    var regionId = 0
    var region = ""
    var suburbId = 0
    var suburb = ""
    var bidCount = 0
    var isReserveMet = false
    var hasReserve = false
    var hasBuyNow = false
    var noteDate: NSDate?
    var reserveState = ReserveState.None
    var isClassified = false
    var openHomes = [OpenHome]()
    var subtitle = ""
    var isBuyNowOnly = false
    var remainingGalleryPlusRelists = 0
    var isOnWatchList = false
    var geographicLocation: GeographicLocation?
    var priceDisplay = ""
    var totalReviewCount = 0
    var positiveReviewCount = 0
    var hasFreeShipping = false
    var isClearance = false
    var wasPrice: NSNumber?
    var percentageOff = 0
    var branding: Branding? // TODO confirm List or single item?
    var isSuperFeatured = false
}