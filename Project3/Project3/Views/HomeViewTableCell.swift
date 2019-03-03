//
//  HomeViewTableCell.swift
//  Project3
//
//  Created by Brandon Ward on 3/3/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class HomeViewTableCell: UITableViewCell {
    static let lock = NSLock()
    static var count = 0 {
        didSet {
            print("Cell count: \(count)")
        }
    }
    
    let increment : Void = {
        HomeViewTableCell.lock.unlock()
        defer { HomeViewTableCell.lock.unlock() }
        HomeViewTableCell.count += 1
    }()
    
    deinit {
         HomeViewTableCell.lock.unlock()
        defer { HomeViewTableCell.lock.unlock() }
        HomeViewTableCell.count -= 1
    }
}
