//
//  Category_TransformTests.swift
//  TradeMe
//
//  Created by will3 on 18/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import XCTest
import Nimble
@testable import TradeMe

class Category_TransformTests: XCTestCase {
    func testTransformName() {
        let category = TradeMe.Category()
        category.name = "Trade Me Motors"
        category.transformName()
        expect(category.name).to(equal("Motors"))
        
        let category2 = TradeMe.Category()
        category2.name = "Trade Me Property"
        category2.transformName()
        expect(category2.name).to(equal("Property"))
        
        let category3 = TradeMe.Category()
        category3.name = "Trade Me Jobs"
        category3.transformName()
        expect(category3.name).to(equal("Jobs"))
    }
}