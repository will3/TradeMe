//
//  ListingDetailCell.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit

class ListingDetailCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
}

extension ListingDetailCell {
    func drawListingDetailRow(row: ListingDetailRow) {
        titleLabel.text = row.title
        detailLabel.text = row.detail
    }
}