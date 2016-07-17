//
//  ListingCell.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit

class ListingCell: UITableViewCell {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var reserveLabel: UILabel!
    
    @IBOutlet weak var buyNowLabel: UILabel!
    @IBOutlet weak var buyNowPriceLabel: UILabel!
    
    @IBOutlet weak var posterWidthConstraint: NSLayoutConstraint!
    
    var currentImageUrl: String = ""
}

extension ListingCell {
    func drawListing(listing: Listing, currencyFormat: NSNumberFormatter) {
        locationLabel.text = listing.region
        if let endDate = listing.endDate {
            timeLabel.text = ListingDateFormatter.formatEndDate(endDate)
        } else {
            timeLabel.text = ""
        }
        
        descriptionLabel.text = listing.title
        
        priceLabel.text = listing.priceDisplay
        reserveLabel.text = ReserveStateFormatter.format(listing.reserveState)
        
        buyNowLabel.text = listing.hasBuyNow ? NSLocalizedString("Buy Now", comment: "") : ""
        buyNowPriceLabel.text = listing.hasBuyNow ?
            "\(currencyFormat.stringFromNumber(listing.buyNowPrice) ?? "")" :
            ""
        
        // Update image
        if listing.pictureHref.isEmpty {
            posterWidthConstraint.constant = 0
            posterImageView.hidden = true
        } else {
            posterWidthConstraint.constant = Layout.listingPosterWidth
            posterImageView.hidden = false
            
            if currentImageUrl != listing.pictureHref {
                posterImageView.image = nil
                posterImageView.loadImageFromURLString(listing.pictureHref, placeholderImage: nil) { finished, error in
                    if finished && error == nil {
                        self.currentImageUrl = listing.pictureHref
                    }
                }
            }
        }
        
        backgroundColor = listing.isFeatured ? Colors.featuredBackground : Colors.normalBackground
    }
}