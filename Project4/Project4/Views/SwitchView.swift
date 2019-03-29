//
//  SwitchView.swift
//  Project3 - Project4
//
//  Created by Brandon Ward on 3/2/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class SwitchView: UIView {
    
    var hitMissLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func draw(_ rect: CGRect) {

        hitMissLabel.textAlignment = NSTextAlignment.center
        hitMissLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 55)
        hitMissLabel.textColor = .white
        hitMissLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(hitMissLabel)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[hitMissLabel]-|", options: [], metrics: nil, views: ["hitMissLabel": hitMissLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[hitMissLabel]-|", options: [], metrics: nil, views: ["hitMissLabel" : hitMissLabel]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
