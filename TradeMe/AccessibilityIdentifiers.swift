//
//  AccessibilityIdentifiers.swift
//  TradeMe
//
//  Created by will3 on 18/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit

enum AccessibilityIdentifiers: String {
    case homeView = "homeView"
    case categoryView = "categoryView"
    case listingDetailView = "listingDetailView"
    
    case filterButton = "filterButton"
    case searchBar = "searchBar"
    
    /**
     Assign identifier to view controller
     
     - parameter controller: view controller to modify
     */
    func set(viewController viewController: UIViewController) {
        let accessibilityView = UIView()
        accessibilityView.backgroundColor = UIColor.clearColor()
        viewController.view.addSubview(accessibilityView)
        accessibilityView.isAccessibilityElement = true
        accessibilityView.accessibilityIdentifier = rawValue
    }
    
    /**
     Assign identifier to view
     
     - parameter controller: view to modify
     */
    func set(view view: UIView) {
        view.accessibilityIdentifier = rawValue
    }
}