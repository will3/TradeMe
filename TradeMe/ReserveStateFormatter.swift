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
            return NSLocalizedString("No reserve", comment: "")
        case .Met:
            return NSLocalizedString("Reserve met", comment: "")
        case .NotMet:
            return NSLocalizedString("Reserve not met", comment: "")
        case .NotApplicable:
            return ""
        }
    }
}