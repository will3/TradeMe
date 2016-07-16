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

class CategoryTitleView: UIView {
    var titleLabel = UILabel()
    var detailLabel = UILabel()
    
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