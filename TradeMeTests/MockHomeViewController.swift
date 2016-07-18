//
//  MockHomeViewController.swift
//  TradeMe
//
//  Created by will3 on 18/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit
@testable import TradeMe

class MockListingTableController: ListingTableControllerProtocol {
    weak var delegate: ListingTableControllerDelegate?
    var scrollViewTracker = ScrollViewTracker()
    
    var hookTableViewCount = 0
    var reloadDataCount = 0
    var loadMore = 0
    var showLoading = 0
    
    var hookTableViewRecord = [UITableView]()
    var reloadDateRecord = [(tableView: UITableView, list: [Listing])]()
    var loadMoreRecord = [(tableView: UITableView, list: [Listing])]()
    var showLoadingRecord = [Bool]()
    
    func hookTableView(tableView: UITableView) -> ListingTableControllerProtocol {
        hookTableViewRecord.append(tableView)
        hookTableViewCount += 1
        return self
    }
    
    func reloadData(tableView: UITableView, list: [Listing]) -> Self {
        reloadDateRecord.append((tableView: tableView, list: list))
        reloadDataCount += 1
        return self
    }
    
    func loadMore(tableView: UITableView, list: [Listing]) -> Self {
        loadMoreRecord.append((tableView: tableView, list: list))
        loadMore += 1
        return self
    }
    
    func showLoading(flag: Bool) -> Self {
        showLoadingRecord.append(flag)
        showLoading += 1
        return self
    }
}