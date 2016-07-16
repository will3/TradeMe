//
//  ListingDetailHeaderView.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit
import KFSwiftImageLoader

class ListingDetailHeaderView : UIView {
    @IBOutlet weak var posterImageView: UIImageView!
    
    func loadPhotos(photos: [Photo]) {
        guard let photo = photos.first else { return }
        posterImageView.loadImageFromURLString(photo.value?.large ?? "")
    }
}