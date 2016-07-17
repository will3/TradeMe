//
//  ListingFooterCell.swift
//  TradeMe
//
//  Created by will3 on 17/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit

class ListingFooterCell : UITableViewCell {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
}

extension ListingFooterCell {
    func drawListingDetail(listingDetail: ListedItemDetail) {
        let idFormat = NSLocalizedString("Listing #: %li", comment: "")
        idLabel.text = String(format: idFormat, listingDetail.listingId)
        let viewsFormat = NSLocalizedString("Views: %li", comment: "")
        viewsLabel.text = String(format: viewsFormat, listingDetail.viewCount)
    }
}