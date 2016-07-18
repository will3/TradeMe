//
//  HomeViewControllerTests.swift
//  TradeMe
//
//  Created by will3 on 18/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import XCTest
import Nimble
import AppInjector
@testable import TradeMe

class HomeViewControllerTests: XCTestCase {
    var viewController: HomeViewController!
    var listingTableController: MockListingTableController!
    var tableView: UITableView!
    var filterButton: UIButton!
    
    override func setUp() {
        viewController = HomeViewController()
        viewController.injectDependencies = false
        
        viewController.listingService = Injector.defaultInjector.resolve("listingService") as! ListingService
        listingTableController = MockListingTableController()
        viewController.listingTableController = listingTableController
        
        tableView = UITableView()
        viewController.tableView = tableView
        
        filterButton = UIButton()
        viewController.filterButton = filterButton
    }
    
    func testViewDidLoad_setupTableView() {
        // Calling view calls viewDidLoad once
        let _ = viewController.view
        
        expect(self.listingTableController.hookTableViewCount).to(equal(1))
        expect(self.listingTableController.hookTableViewRecord[0]).to(equal(tableView))
        XCTAssertTrue(listingTableController.delegate === viewController)
    }
}