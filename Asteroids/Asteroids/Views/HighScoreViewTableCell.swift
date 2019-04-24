//
//  HighScoreViewTableCell.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/6/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class HighScoreViewTableCell: UITableViewCell {
    static let lock = NSLock()
    static var count = 0 {
        didSet {
        }
    }
    
    override func draw(_ rect: CGRect) {
        selectionStyle = .gray
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let increment : Void = {
        HighScoreViewTableCell.lock.unlock()
        defer { HighScoreViewTableCell.lock.unlock() }
        HighScoreViewTableCell.count += 1
    }()
    
    deinit {
        HighScoreViewTableCell.lock.unlock()
        defer { HighScoreViewTableCell.lock.unlock() }
        HighScoreViewTableCell.count -= 1
    }
}
