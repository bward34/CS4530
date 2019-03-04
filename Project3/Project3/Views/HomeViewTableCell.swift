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
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
