//
//  BidsFormatter.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation

class BidsFormatter {
    static func format(number: Int) -> String {
        if number <= 0 {
            return ""
        }
        
        let format = number == 1 ?
            NSLocalizedString("%li bid", comment: "") :
            NSLocalizedString("%li bids", comment: "")
        
        return String(format: format, number)
    }
}