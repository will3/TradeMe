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

/// Class for separator view, this should never be used directly
class _SeparatorView : UIView { }

/// Parameters for drawing a separator
struct SeperatorParams {
    /// Preset for across
    static let across: SeperatorParams = {
        var params = SeperatorParams()
        return params
    }()
    
    /// Preset for row
    static let row: SeperatorParams = {
        var params = SeperatorParams()
        params.left = 12.0
        return params
    }()
    
    /// Preset for none
    static let none: SeperatorParams = {
        var params = SeperatorParams()
        params.none = true
        return params
    }()
    
    /// If true, hide separator
    var none = false
    /// Color of separator
    var color = UIColor(white: 0.66, alpha: 1.0)
    /// Height of separator
    var width = 0.5
    /// Left inset
    var left = 0.0
    /// Right inset
    var right = 0.0
}

extension UIView {
    /**
     Add separator under view
     
     - parameter params: params for separator
     */
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