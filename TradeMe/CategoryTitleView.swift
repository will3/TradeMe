//
//  TitleView.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

/**
 Title view used in Category view nav bar. Shows category name and listing count
 */
class CategoryTitleView: UIView {
    var titleLabel = UILabel()
    var detailLabel = UILabel()
    
    /**
     Set up subviews for this view
     
     Should be called before this view is shown and only once
     
     - returns: self for chainability
     */
    func setupSubviews() -> Self {
        addSubview(titleLabel)
        addSubview(detailLabel)
        titleLabel.snp_makeConstraints { make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(detailLabel.snp_top).offset(5.0)
        }
        detailLabel.snp_makeConstraints { make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.greaterThanOrEqualTo(self)
        }
        
        titleLabel.textColor = UIColor.darkTextColor()
        detailLabel.textColor = UIColor(white: 0.66, alpha: 1.0)
        titleLabel.textAlignment = NSTextAlignment.Center
        detailLabel.textAlignment = NSTextAlignment.Center
        
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
        
        return self
    }
}