//
//  HomeTableController.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit
import KFSwiftImageLoader

protocol ListingTableControllerDelegate: class {
    func listingTableController(tableController: ListingTableController, didSelectListing listing: Listing)
}

/**
 Controller for listing tableView
 
 Usage:
 ```
 let listTableController = ListingTableController()
 // Configure tableView, then reload with list
 listTableController
    .hookTableView(tableView)
    .reloadData(tableView, list: list)
 ```
 */
class ListingTableController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // ListingTableController Sections
    enum Sections: Int {
        case Status = 0
        case List = 1
    }
    
    // Currency format
    var currencyFormat: NSNumberFormatter!
    
    // Scroll view tracker, for advanced scroll view events
    private(set) var scrollViewTracker = ScrollViewTracker()
    
    // Event outlet
    weak var delegate: ListingTableControllerDelegate?
    
    // Flag for empty state
    private var empty = false
    
    // Listings shown, managed internally
    private var list = [Listing]()
    
    // MARK: Public
    
    /**
     Configures a table view for use
     
     - parameter tableView: tableView to configure
     - returns: self for chainability
     */
    func hookTableView(tableView: UITableView) -> ListingTableController {
        tableView.registerCells([CellIdentifiers.listingCell, CellIdentifiers.emptyCell])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120.0
        
        return self
    }
    
    /**
     Reload table view, using listings
     
     - parameter tableView: tableView to reload
     - parameter list: listings to show, if a 0 count list is passed, will show empty state
     - returns: self for chainability
     */
    func reloadData(tableView: UITableView, list: [Listing]) -> Self {
        self.list = list
        empty = list.count == 0
        tableView.reloadData()
        return self
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionEnum = Sections(rawValue: section)!
        
        switch sectionEnum {
        case Sections.Status:
            return empty ? 1 : 0
        case Sections.List:
            return list.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = cellIdentifierForIndexPath(indexPath).rawValue
        let sectionEnum = Sections(rawValue: indexPath.section)!
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) else {
            fatalError(FatalErrors.failedToDequeueCell(cellIdentifier))
        }
        
        switch sectionEnum {
        case .Status:
            guard let emptyCell = cell as? EmptyCell else { return cell }
            emptyCell.messageLabel.text = NSLocalizedString("No results found", comment: "")
            
        case .List:
            guard let listingCell = cell as? ListingCell else {
                fatalError(FatalErrors.wrongCellType(ListingCell.self, actual: cell))
            }
            let listing = list[indexPath.row]
            listingCell.drawListing(listing, currencyFormat: currencyFormat)
        }
        
        return cell
    }
 
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let listing = list[indexPath.row]
        
        delegate?.listingTableController(self, didSelectListing: listing)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // Removes redundant cell separators at end of table
        return UIView()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Forward event for scrollViewTracker
        scrollViewTracker.forwardScrollViewDidScroll(scrollView)
    }
    
    // MARK: Private
    
    // Map indexPath to cellIdentifier
    private func cellIdentifierForIndexPath(indexPath: NSIndexPath) -> CellIdentifiers {
        let sectionEnum = Sections(rawValue: indexPath.section)!
        
        switch sectionEnum {
        case Sections.Status:
            return CellIdentifiers.emptyCell
        case Sections.List:
            return CellIdentifiers.listingCell
        }
    }
}