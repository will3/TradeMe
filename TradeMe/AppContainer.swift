//
//  AppContainer.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import AppInjector

class AppContainer {
    static func setup() {
        let injector = Injector.defaultInjector
        
        injector.bind("currencyFormat") {
            let currencyFormat = NSNumberFormatter()
            currencyFormat.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            
            return currencyFormat
        }
        
        injector.bind("appSettings") { AppSettings.defaultSettings }
        
        injector.bind("listingTableController", type: ListingTableController.self).withDependencies(["currencyFormat", "appSettings"])
        
        injector.bind("homeViewController", type: HomeViewController.self).withDependencies(["listingTableController"])
        
        injector.bind("listingService") {
            return ListingService()
        }.createOnce(true)
        
        injector.bind("listingDetailViewController", type: ListingDetailViewController.self).withDependencies(["listingService"])
    }
}