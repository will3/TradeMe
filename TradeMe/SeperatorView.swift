//
//  SeperatorView.swift
//  TradeMe
//
//  Created by will3 on 17/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class _SeparatorView : UIView { }

struct SeperatorParams {
    static let across: SeperatorParams = {
        var params = SeperatorParams()
        return params
    }()
    
    static let row: SeperatorParams = {
        var params = SeperatorParams()
        params.left = 12.0
        return params
    }()
    
    static let none: SeperatorParams = {
        var params = SeperatorParams()
        params.none = true
        return params
    }()
    
    var none = false
    var color = UIColor(white: 0.66, alpha: 1.0)
    var width = 0.5
    var left = 0.0
    var right = 0.0
}

extension UIView {
    func addSeparator(params: SeperatorParams = SeperatorParams()) {
        var seperatorView = subviews.filter { $0 is _SeparatorView }.first
        
        if params.none {
            seperatorView?.removeFromSuperview()
            return
        }
        
        if seperatorView == nil {
            seperatorView = _SeparatorView()
            addSubview(seperatorView!)
        }
        
        seperatorView!.backgroundColor = params.color
        seperatorView!.snp_updateConstraints { make in
            make.left.equalTo(self).offset(params.left)
            make.right.equalTo(self).offset(params.right)
            make.bottom.equalTo(self)
            make.height.equalTo(params.width)
        }
    }
}