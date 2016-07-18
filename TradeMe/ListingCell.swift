//
//  ListingCell.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit

/**
 Cell to used to display a listing
 
 Shows location, end time, description, poster image, bidding price, reserve status, buy now price, buy now status of the listing
 */
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
    /**
     Draw a listing
     
     - parameter currencyFormat: format used for displaying currencies
     */
    func drawListing(listing: Listing, currencyFormat: NSNumberFormatter) {
        
        // Draw location
        locationLabel.text = listing.region
        
        // Draw end date
        if let endDate = listing.endDate {
            timeLabel.text = ListingDateFormatter.formatEndDate(endDate)
        } else {
            timeLabel.text = ""
        }
        
        // Draw title
        descriptionLabel.text = listing.title
        
        // Draw Bidding
        priceLabel.text = listing.priceDisplay
        reserveLabel.text = listing.formatReserveState()
        
        // Draw Buy now
        buyNowLabel.text = listing.hasBuyNow ? NSLocalizedString("Buy Now", comment: "") : ""
        buyNowPriceLabel.text = listing.hasBuyNow ?
            "\(currencyFormat.stringFromNumber(listing.buyNowPrice) ?? "")" :
            ""
        
        // Draw image
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
        
        // Draw background colors
        backgroundColor = listing.isFeatured ? Colors.featuredBackground : Colors.normalBackground
    }
}