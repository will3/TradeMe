//
//  ListingDetailPage.swift
//  TradeMe
//
//  Created by will3 on 18/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import XCTest

class ListingDetailPage: Page {
    let app: XCUIApplication
    
    let viewIdentifier = AccessibilityIdentifiers.listingDetailView
    
    init(_ app: XCUIApplication) {
        self.app = app
        assertPage(app)
    }
}