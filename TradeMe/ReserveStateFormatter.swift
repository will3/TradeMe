//
//  ReserveStateFormatter.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation

class ReserveStateFormatter {
    static func format(reserveState: ReserveState) -> String {
        switch reserveState {
        case .None:
            return ""
        case .Met:
            return NSLocalizedString("Reserve Met", comment: "")
        case .NotMet:
            return NSLocalizedString("Reserve Not Met", comment: "")
        case .NotApplicable:
            return ""
        }
    }
}