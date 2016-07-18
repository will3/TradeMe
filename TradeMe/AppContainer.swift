//
//  AppContainer.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import AppInjector

/// App DI module
let appContainer = { (injector: Injector) in
    let appSettings = AppSettings.defaultSettings
    let hostUrl = NSURL(string:appSettings.hostUrl)!
    
    injector.bind("appSettings", value: appSettings)
    
    injector.bind("currencyFormat") {
        let currencyFormat = NSNumberFormatter()
        currencyFormat.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        return currencyFormat
    }
    
    injector.bind("listingTableController") {
        let listingTableController = ListingTableController(
            currencyFormat: injector.resolve("currencyFormat") as! NSNumberFormatter)
        return listingTableController
    }
    
    injector.bind("homeViewController", type: HomeViewController.self)
        .withDependencies(["listingService"])
    
    injector.bind("tradeMeApi") {
        let api = TradeMeApi(hostUrl: hostUrl)
        api.headers = appSettings.headers
        return api
    }
    
    injector.bind("cache") { Cache() }.createOnce(true)
    
    injector.bind("promiseManager") { PromiseManager() }.createOnce(true)
    
    injector.bind("listingService") {
        return ListingService(
            api: injector.resolve("tradeMeApi") as! TradeMeApi,
            cache: injector.resolve("cache") as! Cache,
            promiseManager: injector.resolve("promiseManager") as! PromiseManager
        )
        }.createOnce(true)
    
    injector.bind("listingDetailViewController", type: ListingDetailViewController.self).withDependencies(["listingService"])
    
    injector.bind("categoryViewController", type: CategoryViewController.self).withDependencies(["listingService"])
}