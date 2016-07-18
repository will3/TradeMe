//
//  Constants.swift
//  TradeMe
//
//  Created by will3 on 15/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit

/// View controller identifiers
class ViewControllers {
    /// Identifier for CategoryViewController
    static let categoryViewController = "CategoryViewController"
}

/// Cell identifiers, by convention cell nib name and cell identifiers should match this
enum CellIdentifiers : String {
    /// Identifier for CategoryCell
    case categoryCell = "CategoryCell"
    /// Identifier for ListingCell
    case listingCell = "ListingCell"
    /// Identifier for LoadingCell
    case loadingCell = "LoadingCell"
    /// Identifier for EmptyCell
    case emptyCell = "EmptyCell"
    /// Identifier for ListingHeaderCell
    case listingHeaderCell = "ListingHeaderCell"
    /// Identifier for ListingDetailCell
    case listingDetailCell = "ListingDetailCell"
    /// Identifier for HeaderCell
    case headerCell = "HeaderCell"
    /// Identifier for ListingPosterCell
    case listingPosterCell = "ListingPosterCell"
    /// Identifier for ListingFooterCell
    case listingFooterCell = "ListingFooterCell"
}

/// Images used by the app
class Images {
    /// Image for filter button
    static let categoryIcon = UIImage(named: "filter")
}

/// Storyboard used by the app
class Storyboards {
    /// Main story board
    static let main = "Main"
}

/// Segues used by the app
class Segues {
    /// Segue identifier to navigate to category view
    static let category = "category"
    /// Segue identifier to navigate to listing detail
    static let listingDetail = "listingDetail"
}

/// Fatal error messages
class FatalErrors {
    /** 
     Message shown when tableView failed to dequeue cell
     
     - parameter identifier: cell identifier used to dequeue cell
     - returns: a formatted error message
     */
    static func failedToDequeueCell(identifier: String) -> String {
        return "failed to dequeue cell with identifier: \(identifier)"
    }
    
    /**
     Message shown when the cell dequeues, but is of the wrong type
     
     - parameter expected: the expected cell type
     - paramter actual: the actual cell dequeued
     - returns: a formatted error message
     */
    static func wrongCellType(expected: UITableViewCell.Type, actual: UITableViewCell) -> String {
        return "expected cell of type \(expected), but got \(actual)"
    }
}

/**
 Layout constants, extracted from nib files
 */
class Layout {
    /// Poster width in ListingCell
    static let listingPosterWidth = CGFloat(100.0)
    /// Poster height in ListingCell
    static let listingPosterHeight = CGFloat(100.0)
    /// Header height in ListingHeaderCell
    static let listingDetailHeaderHeight = CGFloat(200.0)
    /// Nav bar height
    static let navBarHeight = CGFloat(42.0)
    /// Status bar height
    static let statusBarHeight = CGFloat(20.0)
    /// Top padding of title labe in ListingHeaderCell
    static let listingDetailHeaderTitleTop = CGFloat(24.0)
}


/// Colors used in the app
class Colors {
    /// Primary color
    static let primary = UIColor(netHex: 0xF6BE45)
    /// Secondary color
    static let secondary = UIColor(netHex: 0x924A16)
    /// Background color for featured listings
    static let featuredBackground = UIColor(netHex: 0xFFFEFC)
    /// Background color for non-featured listings
    static let normalBackground = UIColor(netHex: 0xFFFFFF)
}

/// Date constants
class DateConstants {
    /// Time interval for a minute
    static let min = 60.0 * 1000.0
    /// Time interval for an hour
    static let hour = min * 60.0
    /// Time interval for a day
    static let day = hour * 24.0
}