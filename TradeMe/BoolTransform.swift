//
//  BoolTransform.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

class BoolTransform: TransformType {
    typealias Object = Bool
    typealias JSON = String
    
    func transformToJSON(value: Object?) -> JSON? {
        return value == true ? "true" : "false"
    }
    
    func transformFromJSON(value: AnyObject?) -> Object? {
        return (value as? Bool) == true || (value as? String) == "true"
    }
}