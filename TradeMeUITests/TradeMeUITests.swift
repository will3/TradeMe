//
//  TradeMeUITests.swift
//  TradeMeUITests
//
//  Created by will3 on 15/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import XCTest

class TradeMeUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method icons called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSmoke() {
        let app = XCUIApplication()
        HomePage(app)
            .showCategoryPage()
            .select(category: "Property")
            .done()
            .search("Treasure")
            .select(listingAtIndex: 0)
            .wait()
    }
}
