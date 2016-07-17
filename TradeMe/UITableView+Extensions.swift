//
//  TableView+Extensions.swift
//  TradeMe
//
//  Created by will3 on 15/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    /**
     Helper function to register nibs
     
     Assume nib name and cell identifier are the same
     
     - parameter identifiers: identifiers to register
     */
    func registerNibs(identifiers: [CellIdentifiers]) {
        identifiers.forEach { cellIdentifier in
            self.registerNib(
                UINib(nibName: cellIdentifier.rawValue, bundle: NSBundle.mainBundle()),
                forCellReuseIdentifier: cellIdentifier.rawValue)
        }
    }
}