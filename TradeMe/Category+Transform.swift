//
//  Category+Extensions.swift
//  TradeMe
//
//  Created by will3 on 18/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation

// Sepcial categories, names are replaced
private let specialCategories = [
    "Trade Me Motors": "Motors",
    "Trade Me Property": "Property",
    "Trade Me Jobs": "Jobs"
]

extension Category {
    /**
     Transform name of category
     
     Replace any special names, for e.g. Trade Me Jobs to Jobs
     
     - returns: self for chainability
     */
    func transformName() -> Self {
        name = specialCategories[name] ?? name
        
        subcategories.forEach { subcategory in
            subcategory.transformName()
        }
        
        return self
    }
}