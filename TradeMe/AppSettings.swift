//
//  AppSettings.swift
//  TradeMe
//
//  Created by will3 on 17/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation

class AppSettings {
    static let defaultSettings = AppSettings()
    
    var hostUrl = "https://api.tmsandbox.co.nz/v1"
    
    var headers = [
        "Authorization":
        "OAuth oauth_consumer_key=\"A1AC63F0332A131A78FAC304D007E7D1\", oauth_token=\"645502DDB8CBF1383DC24A8A36249B35\", oauth_signature_method=\"PLAINTEXT\", oauth_signature=\"EC7F18B17A062962C6930A8AE88B16C7&922FBF1A2586D04E0DEB3AECDC9569C3\""
    ]
}