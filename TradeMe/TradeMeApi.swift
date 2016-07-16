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

//        Authorization: OAuth oauth_consumer_key="<consumer-key>", oauth_signature_method="PLAINTEXT", oauth_signature="<consumer-secret>&"

class TradeMeApi {
    static let categoryRootNumber = "0"
    
    var hostUrl = NSURL(string: "https://api.tmsandbox.co.nz/v1")!
    
    var headers = [
        "Authorization":
        "OAuth oauth_consumer_key=\"A1AC63F0332A131A78FAC304D007E7D1\", oauth_token=\"645502DDB8CBF1383DC24A8A36249B35\", oauth_signature_method=\"PLAINTEXT\", oauth_signature=\"EC7F18B17A062962C6930A8AE88B16C7&922FBF1A2586D04E0DEB3AECDC9569C3\""
    ]
    
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