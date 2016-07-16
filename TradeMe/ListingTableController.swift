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

class ListingTableController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    enum Sections: Int {
        case Status = 0
        case List = 1
    }
    
    private var list = [Listing]()
    var currencyFormat: NSNumberFormatter!
    var appSettings: AppSettings!
    var scrollViewTracker = ScrollViewTracker()
    weak var delegate: ListingTableControllerDelegate?
    
    // MARK: Public
    
    func hookTableView(tableView: UITableView) {
        tableView.registerCells([CellIdentifiers.listingCell, CellIdentifiers.emptyCell])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120.0
    }
    
    func reloadData(tableView: UITableView, list: [Listing]) {
        self.list = list
        tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionEnum = Sections(rawValue: section)!
        
        switch sectionEnum {
        case Sections.Status:
            return list.count == 0 ? 1 : 0
        case Sections.List:
            return list.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = cellIdentifierForIndexPath(indexPath)
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
            listingCell.drawListing(listing, appSettings: appSettings, currencyFormat: currencyFormat)
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
        scrollViewTracker.forwardScrollViewDidScroll(scrollView)
    }
    
    // MARK: Private
    
    private func cellIdentifierForIndexPath(indexPath: NSIndexPath) -> String {
        let sectionEnum = Sections(rawValue: indexPath.section)!
        
        switch sectionEnum {
        case Sections.Status:
            return CellIdentifiers.emptyCell
        case Sections.List:
            return CellIdentifiers.listingCell
        }
    }
}