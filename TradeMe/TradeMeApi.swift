//
//  TradeMeApi.swift
//  TradeMe
//
//  Created by will3 on 15/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import PromiseKit
import ObjectMapper

enum TradeMeApiError: ErrorType {
    case BadData
}

/**
 Api wrapper for TradeMe
 */
class TradeMeApi {
    /// Category number for the "Root" category
    static let categoryRootNumber = "0"
    
    /**
     Designated constructor
     
     - parameter hostUrl: host url to use
     */
    init(hostUrl: NSURL) {
        self.hostUrl = hostUrl
    }
    
    /// Host url to use
    var hostUrl: NSURL
    
    /// Headers used for authentication purposes
    var headers: [String: String]?
    
    /**
     Get category
     
     - parameter request: request object
     - returns: promise of Category
     */
    func getCategory(request: GetCategoryRequest = GetCategoryRequest()) -> Promise<Category> {
        let url = hostUrl.URLByAppendingPathComponent("Categories/\(request.number).\(request.fileFormat)")
        
        return Promise { fulfill, reject in
            let paramters = request.toJSON()
            Alamofire.request(.GET, url, parameters: paramters, encoding: ParameterEncoding.URL, headers: headers)
                .responseObject { (response: Response<Category, NSError>) in
                    if let error = response.result.error {
                        return reject(error)
                    }
                    
                    if let value = response.result.value {
                        return fulfill(value)
                    }
                    
                    reject(TradeMeApiError.BadData)
            }
        }
    }
    
    /**
     Search
     
     - parameter request: request object
     - returns: promise of SearchResponse
     */
    func search(request: SearchRequest = SearchRequest()) -> Promise<SearchResponse> {
        let url = hostUrl.URLByAppendingPathComponent("Search/General.json")
        
        return Promise { fulfill, reject in
            let parameters = request.toJSON()
            Alamofire.request(.GET, url, parameters: parameters, encoding: ParameterEncoding.URL, headers: headers)
                .responseObject { (response: Response<SearchResponse, NSError>) in
                    if let error = response.result.error {
                        return reject(error)
                    }
                    
                    if let value = response.result.value {
                        return fulfill(value)
                    }
                    
                    reject(TradeMeApiError.BadData)
            }
        }
    }
    
    /**
     Get listing detail
     
     - parameter request: request object
     - returns: promise of ListedItemDetail
     */
    func getListingDetail(request: GetListingDetailRequest = GetListingDetailRequest()) -> Promise<ListedItemDetail> {
        let url = hostUrl.URLByAppendingPathComponent("Listings/\(request.listingId).\(request.file_format)")
        
        return Promise { fulfill, reject in
            let parameters = request.toJSON()
            Alamofire.request(.GET, url, parameters: parameters, encoding: ParameterEncoding.URL, headers: headers)
                .responseObject { (response: Response<ListedItemDetail, NSError>) in
                    if let error = response.result.error {
                        return reject(error)
                    }
                    
                    if let value = response.result.value {
                        return fulfill(value)
                    }
                    
                    reject(TradeMeApiError.BadData)
            }
        }
    }
}