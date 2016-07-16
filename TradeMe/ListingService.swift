//
//  ListingService.swift
//  TradeMe
//
//  Created by will3 on 15/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import PromiseKit

class Cache {
    var categoryMap = [String: Category]()
    
    func getCategory(number: String) -> Category? {
        return categoryMap[number]
    }
    
    func setCategory(number: String, category: Category) {
        categoryMap[number] = category
    }
}

class ListingService: NSObject {
    var api = TradeMeApi()
    var promiseManager = PromiseManager()
    var cache = Cache()
    
    var specialCategories = [
        "Trade Me Motors": "Motors",
        "Trade Me Property": "Property",
        "Trade Me Jobs": "Jobs"
    ]
    
    func getCategory(number: String?) -> Promise<Category> {
        let number = number ?? TradeMeApi.categoryRootNumber
        let isRoot = number == TradeMeApi.categoryRootNumber
        
        let key = "getCategories" + number
        
        let request = GetCategoryRequest()
        request.withCounts = true
        // Assume all root categories expandable, therefore not needing to fetch 2 levels, for performance reasons
        request.depth = isRoot ? 1 : 2
        request.number = number
        
        let cachedCategory = cache.getCategory(number)
        
        return cachedCategory != nil ?
            // Resolve with cache if exists
            Promise(cachedCategory!) :
            // Resolve with async task
            promiseManager
                .dequeue(key) {
                    return self.api.getCategory(request) }
                .then { category in
                    self.transformCategory(category, specialCategories: self.specialCategories)
                    category.isRoot = isRoot
                    self.cache.setCategory(number, category: category)
                    return Promise(category)
        }
    }
    
    func search(request: SearchRequest = SearchRequest()) -> Promise<SearchResponse> {
        return api.search(request)
    }
    
    func getListingDetail(request: GetListingDetailRequest) -> Promise<ListedItemDetail> {
        return api.getListingDetail(request)
    }
    
    // MARK: Private
    
    private func transformCategory(category: Category, specialCategories: [String: String]) {
        category.name = specialCategories[category.name] ?? category.name
        
        category.subcategories.forEach { subcategory in
            self.transformCategory(subcategory, specialCategories: specialCategories)
        }
    }
}