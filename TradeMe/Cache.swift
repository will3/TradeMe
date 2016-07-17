//
//  Cache.swift
//  TradeMe
//
//  Created by will3 on 17/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation

class Cache {
    private var categoryMap = [String: Category]()
    
    func getCategory(number: String) -> Category? {
        return categoryMap[number]
    }
    
    func setCategory(number: String, category: Category) {
        categoryMap[number] = category
    }
}