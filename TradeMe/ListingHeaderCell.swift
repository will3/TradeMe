//
//  ListingBidCell.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit

class ListingHeaderCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var reserveLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bidsButton: UIButton!
}

extension ListingHeaderCell {
    func drawListingDetail(listingDetail: ListedItemDetail) {
        titleLabel.text = listingDetail.title
        priceLabel.text = listingDetail.priceDisplay
        reserveLabel.text = ReserveStateFormatter.format(listingDetail.reserveState)
        timeLabel.text = listingDetail.endDate == nil ? "" :
            ListingDateFormatter.formatEndDate(listingDetail.endDate!)
        
        let numBids = listingDetail.bids?.totalCount ?? 0
        if numBids > 0 {
            bidsButton.setTitle(BidsFormatter.format(numBids), forState: UIControlState.Normal)
        }
    }
}