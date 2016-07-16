//
//  ListingPosterCell.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit

class ListingPosterCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
}

extension ListingPosterCell {
    func drawListingDetail(listingDetail: ListedItemDetail) {
        if let photo = listingDetail.photos.first {
            posterImageView.loadImageFromURLString(photo.value?.large ?? "")
        }
        
        overlayView.backgroundColor = Colors.primary
    }
}