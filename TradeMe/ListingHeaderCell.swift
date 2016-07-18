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
}

extension ListingHeaderCell {
    /**
     Draw a detailed listing
     
     - parameter listingDetail: detail listing to draw
     */
    func drawListingDetail(listingDetail: ListedItemDetail) {
        titleLabel.text = listingDetail.title
        priceLabel.text = listingDetail.priceDisplay
        reserveLabel.text = listingDetail.formatReserveState()
    }
}