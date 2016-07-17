//
//  SortOrder.swift
//  TradeMe
//
//  Created by will3 on 17/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation

// WIP
extension SortOrder {
    func format() -> String {
        switch self {
        case .FeaturedFirst:
            return "Feature First"
        case .TitleAsc:
            return "Title"
        case .ExpiryAsc:
            return "Latest listings"
        case .ExpiryDesc:
            return "Closing soon"
        case .PriceAsc:
            return "Lowest price"
        case .PriceDesc:
            return "Highest price"
        case .BidsMost:
            return "Most bids"
        case .BuyNowAsc:
            return "Lowest Buy Now"
        case .BuyNowDesc:
            return "Highest Buy Now"
        case .Default:
            return ""
        case .SuperGridFeaturedFirst:
            return ""
        case .ReviewsDesc:
            return ""
        case .HighestSalary:
            return ""
        case .LowestSalary:
            return ""
        case .LowestKilometres:
            return ""
        case .HighestKilometres:
            return ""
        case .NewestVehicle:
            return ""
        case .OldestVehicle:
            return ""
        case .BestMatch:
            return ""
        }
    }
}