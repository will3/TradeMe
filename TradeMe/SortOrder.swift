//
//  SortOrder.swift
//  TradeMe
//
//  Created by will3 on 18/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation

/// Model generated from Trade Me API, for detailed documentation refer to http://developer.trademe.co.nz/
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