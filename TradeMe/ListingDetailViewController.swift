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

struct ListingDetailRow {
    var title = ""
    var detail = ""
    
    init(title: String, detail: String) {
        self.title = title
        self.detail = detail
    }
}

class ListingDetailViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private enum Sections : Int {
        case Poster = 0
        case Header = 1
        case DetailHeader = 2
        case Details = 3
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    let titleLabel = UILabel()
    
    var listing: Listing?
    var listingDetail: ListedItemDetail?
    private var detailRows = [ListingDetailRow]()
    
    var posterCell: ListingPosterCell?
    
    // MARK: Injected
    
    var listingService: ListingService!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Injector.defaultInjector.injectDependencies(self)
        
        tableView.registerCells([CellIdentifiers.listingHeaderCell, CellIdentifiers.listingDetailCell, CellIdentifiers.headerCell, CellIdentifiers.listingPosterCell])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 24.0
        
        if let listing = listing {
            listingDetail = ListedItemDetail(JSON: listing.toJSON())
            
            let request = GetListingDetailRequest()
            request.listingId = listing.listingId
            listingService.getListingDetail(request).then { listingDetail -> Void in
                self.listingDetail = listingDetail
                self.detailRows = self.getDetailRows(listingDetail)
                self.tableView.reloadData()
                self.titleLabel.text = listingDetail.title
            }
        }
        
        topBar.addSubview(titleLabel)
        titleLabel.textAlignment = NSTextAlignment.Center
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func updateTitleLabelFrame(y: CGFloat?) {
        let y = y ?? topBar.bounds.height
        let titleLeftPadding = CGFloat(60.0)
        let titleRightPadding = CGFloat(60.0)
        titleLabel.frame = CGRectMake(titleLeftPadding, y, topBar.bounds.width - titleLeftPadding - titleRightPadding, topBar.bounds.height)
    }
    
    private func getDetailRows(listingDetail: ListedItemDetail) -> [ListingDetailRow] {
        var list = [ListingDetailRow]()
        
        list.append(ListingDetailRow(
            title: NSLocalizedString("Condition", comment: ""),
            detail: listingDetail.formatCondition())
        )
        
        if !listingDetail.body.isEmpty {
            list.append(ListingDetailRow(
                title: NSLocalizedString("Description", comment: ""),
                detail: listingDetail.body))
        }
        
        if listingDetail.shippingOptions.count > 0 {
            list.append(ListingDetailRow(
                title: NSLocalizedString("Shipping", comment: ""),
                detail: listingDetail.formatShippingOptions()))
        }
        
        if !listingDetail.paymentOptions.isEmpty {
            list.append(ListingDetailRow(
                title: NSLocalizedString("Payment", comment: ""),
                detail: listingDetail.formatPaymentOptions()))
        }
        
        list.append(ListingDetailRow(
            title: NSLocalizedString("Pickups", comment: ""),
            detail: listingDetail.formatPickups()))
        
        return list
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func onBackPressed(sender: UIButton) {
        navigationController?.dismissViewControllerAnimated(true) { }
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionEnum = Sections(rawValue: section)!
        
        switch sectionEnum {
        case .Poster:
            return 1
        case .Header:
            return 1
        case .DetailHeader:
            return 1
        case .Details:
            return detailRows.count
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
        case .Poster:
            guard let posterCell = cell as? ListingPosterCell else {
                fatalError(FatalErrors.wrongCellType(ListingPosterCell.self, actual: cell))
            }
            posterCell.drawListingDetail(listingDetail)
            self.posterCell = posterCell
        case .Header:
            guard let headerCell = cell as? ListingHeaderCell else {
                fatalError(FatalErrors.wrongCellType(ListingHeaderCell.self, actual: cell))
            }
            headerCell.drawListingDetail(listingDetail)
        case .DetailHeader:
            guard let headerCell = cell as? HeaderCell else {
                fatalError(FatalErrors.wrongCellType(ListingHeaderCell.self, actual: cell))
            }
            headerCell.titleLabel.text = NSLocalizedString("DETAILS", comment: "")
        case .Details:
            guard let detailCell = cell as? ListingDetailCell else {
                fatalError(FatalErrors.wrongCellType(ListingDetailCell.self, actual: cell))
            }
            let row = detailRows[indexPath.row]
            detailCell.drawListingDetailRow(row)
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func cellIdentifierForIndexPath(indexPath: NSIndexPath) -> String {
        let sectionEnum = Sections(rawValue: indexPath.section)!
        
        switch sectionEnum {
        case .Header:
            return CellIdentifiers.listingHeaderCell
        case .DetailHeader:
            return CellIdentifiers.headerCell
        case .Details:
            return CellIdentifiers.listingDetailCell
        case .Poster:
            return CellIdentifiers.listingPosterCell
        }
    }
    
    // MARK: UITableViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        let maxY = Layout.listingDetailHeaderHeight - Layout.navBarHeight - Layout.statusBarHeight
        let ratio = 1 - ((maxY - y) / maxY)
        
        self.posterCell?.overlayView.alpha = ratio
        
        topBar.hidden = ratio < 1.0
        
        let titleLabelMaxY = maxY + Layout.listingDetailHeaderTitleTop
        let titleLabelYDiff = (titleLabelMaxY - y)
        let minTitleLabelY = CGFloat(0.0)
        
        if titleLabelYDiff < 0 {
            var titleLabelOffsetY = titleLabelYDiff + Layout.navBarHeight
            if titleLabelOffsetY < minTitleLabelY {
                titleLabelOffsetY = minTitleLabelY
            }
            updateTitleLabelFrame(titleLabelOffsetY)
        }
        
    }
}