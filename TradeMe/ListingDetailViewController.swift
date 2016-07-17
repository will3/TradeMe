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

/**
 Shows listing details
 */
class ListingDetailViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    enum Sections : Int {
        case Poster = 0
        case Header = 1
        case DetailHeader = 2
        case Details = 3
        case Footer = 4
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backButton2: UIButton!
    
    // MARK: Properties
    
    // Listing to show
    var listing: Listing?
    
    // Title label in nav bar
    private let titleLabel = UILabel()
    
    // Listing detail fetched
    private var listingDetail: ListedItemDetail?
    
    // Rows in Sections.Details
    private var details = [ListingDetail]()
    
    // Reference to ListingPosterCell drawn
    private var posterCell: ListingPosterCell?
    
    // MARK: Injected
    
    var listingService: ListingService!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Injector.defaultInjector.injectDependencies(self)
        
        // Configure table view
        tableView.registerNibs([CellIdentifiers.listingHeaderCell, CellIdentifiers.listingDetailCell, CellIdentifiers.headerCell, CellIdentifiers.listingPosterCell, CellIdentifiers.listingFooterCell])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 24.0
        
        if let listing = listing {
            // Merge listing detail using ObjectMapper
            listingDetail = ListedItemDetail(JSON: listing.toJSON())
            
            let request = GetListingDetailRequest()
            request.listingId = listing.listingId
            
            listingService.getListingDetail(request).then { listingDetail -> Void in
                self.listingDetail = listingDetail
                self.details = listingDetail.getDetails()
                self.tableView.reloadData()
                
                self.titleLabel.text = listingDetail.title
            }
        }
        
        // Configure title label
        topBar.addSubview(titleLabel)
        titleLabel.textAlignment = NSTextAlignment.Center
        
        // Add a shadow line
        var params = SeperatorParams.across
        params.color = Colors.secondary
        topBar.addSeparator(params)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: IBAction
    
    @IBAction func onBackPressed(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionEnum = Sections(rawValue: section)!
        
        switch sectionEnum {
        case .Poster:
            return listingDetail?.photos.count > 0 ? 1 : 0
        case .Header:
            return 1
        case .DetailHeader:
            return 1
        case .Details:
            return details.count
        case .Footer:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = cellIdentifierForIndexPath(indexPath).rawValue
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
            let row = details[indexPath.row]
            detailCell.drawListingDetail(row)
            
        case .Footer:
            guard let footerCell = cell as? ListingFooterCell else {
                fatalError(FatalErrors.wrongCellType(ListingFooterCell.self, actual: cell))
            }
            footerCell.drawListingDetail(listingDetail)
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        let seperatorParams = seperatorParamsForIndexPath(indexPath)
        cell.contentView.addSeparator(seperatorParams)
        
        cell.backgroundView = UIView()
        cell.backgroundView?.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = backgroundColorForIndexPath(indexPath)
        
        return cell
    }
    
    func cellIdentifierForIndexPath(indexPath: NSIndexPath) -> CellIdentifiers {
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
        case .Footer:
            return CellIdentifiers.listingFooterCell
        }
    }
    
    // MARK: UITableViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        let maxY = Layout.listingDetailHeaderHeight - Layout.navBarHeight - Layout.statusBarHeight
        let ratio = 1 - ((maxY - y) / maxY)
        
        posterCell?.overlayView.alpha = ratio
        backButton.alpha = 1 - ratio
        backButton2.alpha = ratio
        
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
    
    // MARK: Private
    
    private func seperatorParamsForIndexPath(indexPath: NSIndexPath) -> SeperatorParams {
        let sectionEnum = Sections(rawValue: indexPath.section)!
        
        switch sectionEnum {
        case .DetailHeader:
            return SeperatorParams.across
        case .Details:
            return indexPath.row == tableView.numberOfRowsInSection(indexPath.section) - 1 ?
                SeperatorParams.across : SeperatorParams.row
        default:
            return SeperatorParams.none
        }
    }
    
    private func backgroundColorForIndexPath(indexPath: NSIndexPath) -> UIColor {
        let sectionEnum = Sections(rawValue: indexPath.section)!
        
        switch sectionEnum {
        case .Details:
            return UIColor.whiteColor()
        default:
            return UIColor.clearColor()
        }
    }

    private func updateTitleLabelFrame(y: CGFloat?) {
        let y = y ?? topBar.bounds.height
        let titleLeftPadding = CGFloat(60.0)
        let titleRightPadding = CGFloat(60.0)
        titleLabel.frame = CGRectMake(titleLeftPadding, y, topBar.bounds.width - titleLeftPadding - titleRightPadding, topBar.bounds.height)
    }
}