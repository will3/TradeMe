//
//  CategoryPage.swift
//  TradeMe
//
//  Created by will3 on 18/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import XCTest

class CategoryPage: Page {
    
    let viewIdentifier = AccessibilityIdentifiers.categoryView
    let app: XCUIApplication
    
    var doneButton: XCUIElement {
        return app.buttons["Done"]
    }
    
    init(_ app: XCUIApplication) {
        self.app = app
        assertPage(app)
    }
    
    func select(category category: String) -> CategoryPage {
        app.cells[category].tap()
        return self
    }
    
    func done() -> HomePage {
        doneButton.tap()
        return HomePage(app)
    }
}