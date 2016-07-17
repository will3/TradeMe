//
//  ListingService.swift
//  TradeMe
//
//  Created by will3 on 15/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import PromiseKit

/**
 Service for retrieving categories, listings and listing details
 */
class ListingService: NSObject {
    var api: TradeMeApi
    var cache: Cache
    var promiseManager: PromiseManager
    
    init(api: TradeMeApi, cache: Cache, promiseManager: PromiseManager) {
        self.api = api
        self.cache = cache
        self.promiseManager = promiseManager
    }
    
    // Sepcial categories, names are replaced
    var specialCategories = [
        "Trade Me Motors": "Motors",
        "Trade Me Property": "Property",
        "Trade Me Jobs": "Jobs"
    ]
    
    /**
     Get category
     
     - parameter number: category number, leave empty for root category
     - returns: promise of Category
     */
    func getCategory(number: String?) -> Promise<Category> {
        let isRoot = number == nil
        let number = number ?? TradeMeApi.categoryRootNumber
        
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
                .get(key) {
                    return self.api.getCategory(request) }
                .then { category in
                    self.transformCategory(category, specialCategories: self.specialCategories)
                    category.isRoot = isRoot
                    self.cache.setCategory(number, category: category)
                    return Promise(category)
        }
    }
    
    /**
     Search
     
     - parameter request: request object
     - returns: promise of SearchResponse
     */
    func search(request: SearchRequest = SearchRequest()) -> Promise<SearchResponse> {
        return api.search(request)
    }
    
    /**
     Get listing detail
     
     - parameter request: request object
     - returns: promise of ListedItemDetail
     */
    func getListingDetail(request: GetListingDetailRequest) -> Promise<ListedItemDetail> {
        return api.getListingDetail(request)
    }
    
    // MARK: Private
    
    /**
     Transform category recursively,
     replacing special category names
     */
    private func transformCategory(category: Category, specialCategories: [String: String]) {
        category.name = specialCategories[category.name] ?? category.name
        
        category.subcategories.forEach { subcategory in
            self.transformCategory(subcategory, specialCategories: specialCategories)
        }
    }
}