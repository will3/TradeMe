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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var wasLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    @IBOutlet weak var posterWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var posterHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var posterLeftConstraint: NSLayoutConstraint!
    
    var currentImageUrl: String = ""
}

extension ListingCell {
    func drawListing(listing: Listing, appSettings: AppSettings, currencyFormat: NSNumberFormatter) {
        descriptionLabel.text = listing.title
        priceLabel.text = listing.priceDisplay
        wasLabel.text = listing.wasPrice == nil ?
            "" :
            "\(appSettings.currencySymbol)\(currencyFormat.stringFromNumber(listing.wasPrice!) ?? "")"
        
        shippingLabel.text = listing.hasFreeShipping ? "Free Shipping" : ""
        if listing.pictureHref.isEmpty {
            posterWidthConstraint.constant = 0
            posterHeightConstraint.constant = 0
            posterImageView.hidden = true
        } else {
            posterWidthConstraint.constant = Layout.listingPosterWidth
            posterHeightConstraint.constant = Layout.listingPosterHeight
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
    }
}