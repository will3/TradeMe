//
//  StandardDateTransform.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

// Transforms a date string with format "yyyy-MM-dd'T'HH:mm:ss'Z'"
class StandardDateTransform: TransformType {
    static let dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return dateFormatter
    }()
    
    typealias Object = NSDate
    typealias JSON = String
    
    func transformToJSON(value: Object?) -> JSON? {
        guard let value = value else {
            return nil
        }
        
        return StandardDateTransform.dateFormatter.stringFromDate(value)
    }
    
    func transformFromJSON(value: AnyObject?) -> Object? {
        guard let value = value as? String else {
            return nil
        }
        
        return StandardDateTransform.dateFormatter.dateFromString(value)
    }
}