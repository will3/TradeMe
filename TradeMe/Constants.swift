//
//  Constants.swift
//  TradeMe
//
//  Created by will3 on 15/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit

class ViewControllers {
    static let categoryViewController = "CategoryViewController"
}

enum CellIdentifiers : String {
    case categoryCell = "CategoryCell"
    case listingCell = "ListingCell"
    case loadingCell = "LoadingCell"
    case emptyCell = "EmptyCell"
    case listingHeaderCell = "ListingHeaderCell"
    case listingDetailCell = "ListingDetailCell"
    case headerCell = "HeaderCell"
    case listingPosterCell = "ListingPosterCell"
    case listingFooterCell = "ListingFooterCell"
}

class Images {
    static let categoryIcon = UIImage(named: "filter")
}

class Storyboards {
    static let main = "Main"
}

class Segues {
    static let category = "category"
    static let listingDetail = "listingDetail"
}

class FatalErrors {
    static func failedToDequeueCell(identifier: String) -> String {
        return "failed to dequeue cell with identifier: \(identifier)"
    }
    
    static func wrongCellType(expected: UITableViewCell.Type, actual: UITableViewCell) -> String {
        return "expected cell of type \(expected), but got \(actual)"
    }
}

class Layout {
    static let listingPosterWidth = CGFloat(100.0)
    static let listingPosterHeight = CGFloat(100.0)
    static let homeHeaderContainerHeight = CGFloat(42.0)
    static let listingDetailHeaderHeight = CGFloat(200.0)
    static let navBarHeight = CGFloat(42.0)
    static let statusBarHeight = CGFloat(20.0)
    static let listingDetailHeaderTitleTop = CGFloat(24.0)
}

class Colors {
    static let primary = UIColor(netHex: 0xF6BE45)
    static let secondary = UIColor(netHex: 0x924A16)
    static let featuredBackground = UIColor(netHex: 0xFFFEFC)
    static let normalBackground = UIColor(netHex: 0xFFFFFF)
}

class DateConstants {
    static let min = 60.0 * 1000.0
    static let hour = min * 60.0
    static let day = hour * 24.0
}