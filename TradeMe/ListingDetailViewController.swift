//
//  ListingDetailViewController.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit
import AppInjector

class ListingDetailViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private enum Sections : Int {
        case Header = 0
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var listing: Listing?
    var listingDetail: ListedItemDetail?
    
    var headerView = NSBundle.mainBundle().loadNibNamed(Nibs.listingDetailHeaderView, owner: nil, options: nil)[0] as! ListingDetailHeaderView
    
    // MARK: Injected
    
    var listingService: ListingService!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Injector.defaultInjector.injectDependencies(self)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        headerView.backgroundColor = UIColor.redColor()
        headerView.bounds = CGRectMake(0, 0, tableView.bounds.width, 100.0)
        tableView.tableHeaderView = headerView
        
        
        if let listing = listing {
            listingDetail = ListedItemDetail(JSON: listing.toJSON())
            
            let request = GetListingDetailRequest()
            request.listingId = listing.listingId
            listingService.getListingDetail(request).then { listingDetail -> Void in
                self.headerView.loadPhotos(listingDetail.photos)
                self.listingDetail = listingDetail
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionEnum = Sections(rawValue: section)!
        
        switch sectionEnum {
        case .Header:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = cellIdentifierForIndexPath(indexPath)
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) else {
            fatalError(FatalErrors.failedToDequeueCell(cellIdentifier))
        }
        
        guard let listingDetail = self.listingDetail else {
            return cell
        }
        
        let sectionEnum = Sections(rawValue: indexPath.section)!
        
        switch sectionEnum {
        case .Header:
            guard let headerCell = cell as? ListingHeaderCell else {
                fatalError(FatalErrors.wrongCellType(ListingHeaderCell.self, actual: cell))
            }
            
            headerCell.drawListingDetail(listingDetail)
        }
        
        return cell
    }
    
    func cellIdentifierForIndexPath(indexPath: NSIndexPath) -> String {
        let sectionEnum = Sections(rawValue: indexPath.section)!
        
        switch sectionEnum {
        case .Header:
            return CellIdentifiers.listingHeaderCell
        }
    }
    // MARK: UITableViewDelegate
    
}