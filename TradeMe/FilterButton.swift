//
//  FilterButton.swift
//  TradeMe
//
//  Created by will3 on 17/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit

class FilterButton: UIButton {
    override func willMoveToWindow(newWindow: UIWindow?) {
        layer.cornerRadius = bounds.width / 2
        
        layer.masksToBounds = false;
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSizeMake(2.0, 2.0);
        layer.shadowOpacity = 0.5;
    }
}