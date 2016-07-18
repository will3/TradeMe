//
//  Cache.swift
//  TradeMe
//
//  Created by will3 on 17/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation

/// App Cache
class Cache {
    private var categoryMap = [String: Category]()
    
    /**
     Get a category by number
     
     - parameter number: category number
     - returns: nil if category doesn't exist
     */
    func getCategory(number: String) -> Category? {
        return categoryMap[number]
    }
    
    /**
     Set category
     
     - parameter number: category number
     - parameter category: category object to store
     */
    func setCategory(number: String, category: Category) {
        categoryMap[number] = category
    }
}