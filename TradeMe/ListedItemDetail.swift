//
//  ListedItemDetail.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

class ListedItemDetail: Listing {
    override func mapping(map: Map) {
        super.mapping(map)
        
        bidderAndWatchers <- map["BidderAndWatchers"]
        photoId <- map["PhotoId"]
        viewCount <- map["ViewCount"]
        categoryName <- map["CategoryName"]
        attributes <- map["Attributes"]
        relistedItemId <- map["RelistedItemId"]
        reservePrice <- map["ReservePrice"]
        hasMultiple <- map["HasMultiple"]
        quantity <- map["Quantity"]
        isFlatShippingCharge <- map["IsFlatShippingCharge"]
        minimumNextBidAmount <- map["MinimumNextBidAmount"]
        sendPaymentInstructions <- map["SendPaymentInstructions"]
        canUsePayNowInstant <- map["CanUsePayNowInstant"]
        externalReferenceId <- map["ExternalReferenceId"]
        SKU <- map["SKU"]
        availableToBuy <- map["AvailableToBuy"]
        body <- map["Body"]
        bids <- map["Bids"]
        questions <- map["Questions"]
        photos <- map["Photos"]
        allowsPickups <- map["AllowsPickups"]
        shippingOptions <- map["ShippingOptions"]
        paymentOptions <- map["PaymentOptions"]
        isOrNearOffer <- map["IsOrNearOffer"]
        unansweredQuestionCount <- map["UnansweredQuestionCount"]
        authenticatedMembersOnly <- map["AuthenticatedMembersOnly"]
        offerStatus <- map["OfferStatus"]
        firearmsLicenseRequiredToBuy <- map["FirearmsLicenseRequiredToBuy"]
        over18DeclarationRequiredToBuy <- map["Over18DeclarationRequiredToBuy"]
        canOffer <- map["CanOffer"]
        canRelist <- map["CanRelist"]
        withdrawnBySeller <- map["WithdrawnBySeller"]
        isInTradeProtected <- map["IsInTradeProtected"]
        isInCart <- map["IsInCart"]
        isLeading <- map["IsLeading"]
        isOutbid <- map["IsOutbid"]
        canAddToCart <- map["CanAddToCart"]
        cartItemId <- map["CartItemId"]
        currentAutoBid <- map["CurrentAutoBid"]
        contactCount <- map["ContactCount"]
    }
    
    var bidderAndWatchers = 0
    var photoId = 0
    var viewCount = 0
    var categoryName = ""
    var attributes = [Attribute]()
    var relistedItemId = 0
    var reservePrice: NSNumber?
    var hasMultiple = false
    var quantity = 0
    var isFlatShippingCharge = false
    var minimumNextBidAmount: NSNumber?
    var sendPaymentInstructions = false
    var canUsePayNowInstant = false
    var externalReferenceId = ""
    var SKU = ""
    var availableToBuy = ""
    var body = ""
    var bids: BidCollection?
    var questions: Questions?
    var photos = [Photo]()
    var allowsPickups = "" // None Allow Demand Forbid
    var shippingOptions = [ShippingOption]()
    var paymentOptions = ""
    var isOrNearOffer = false
    var unansweredQuestionCount = 0
    var authenticatedMembersOnly = false
    var offerStatus = "" // None Active Withdrawn Expired Declined Accepted
    var firearmsLicenseRequiredToBuy = false
    var over18DeclarationRequiredToBuy = false
    var canOffer = false
    var canRelist = false
    var withdrawnBySeller = false
    var isInTradeProtected = false
    var isInCart = false
    var isLeading = false
    var isOutbid = false
    var canAddToCart = false
    var cartItemId = 0
    var currentAutoBid = 0
    var contactCount = 0
    
    // Not implemented
    // var Member: Member
    // var dealership: Dealership?
    // var agency: Agency?
    // var store: Store?
    // var contactDetails: ContactDetails?
    // var sales = [Sale]()
    // var pendingOffer: FixedPriceOfferDetails
    // var closedOffer: FixedPriceOfferDetails
    // var DonationRecipient: Charity
    // var CurrentShippingPromotion: CurrentShippingPromotion
    // var MemberProfile: SimpleMemberProfile
    // var EmbeddedContent: EmbeddedContent
    // var SponsorLinks = [SponsorLink]()
    // var MotorWebBasicReport: MotorWebBasicReport
}