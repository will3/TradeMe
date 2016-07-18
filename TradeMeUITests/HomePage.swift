//
//  HomePage.swift
//  TradeMe
//
//  Created by will3 on 18/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import XCTest

class HomePage: Page {
    
    let viewIdentifier = AccessibilityIdentifiers.homeView
    let app: XCUIApplication
    
    var filterButton: XCUIElement {
        return app.buttons[AccessibilityIdentifiers.filterButton.rawValue]
    }
    
    var searchBar: XCUIElement {
        return app.otherElements[AccessibilityIdentifiers.searchBar.rawValue]
            .searchFields.elementBoundByIndex(0)
    }
    
    var searchButton: XCUIElement {
        return app.buttons["Search"]
    }
    
    init(_ app: XCUIApplication) {
        self.app = app
        assertPage(app)
    }
    
    func showCategoryPage() -> CategoryPage {
        filterButton.tap()
        return CategoryPage(app)
    }
    
    func search(text: String) -> HomePage {
        searchBar.tap()
        searchBar.typeText(text)
        searchButton.tap()
        return self
    }
    
    func select(listingAtIndex index: UInt = 0) -> ListingDetailPage {
        app.cells.elementBoundByIndex(index).tap()
        return ListingDetailPage(app)
    }
}