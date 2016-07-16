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
    func registerCells(cellIdentifiers: [String]) {
        cellIdentifiers.forEach { cellIdentifier in
            self.registerNib(
                UINib(nibName: cellIdentifier, bundle: NSBundle.mainBundle()),
                forCellReuseIdentifier: cellIdentifier)
        }
    }
}