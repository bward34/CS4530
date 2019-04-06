//
//  ShipView.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/4/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class ShipView : UIView {

    
    override init(frame: CGRect) {
        super.init(frame : .zero)
        backgroundColor = .blue
    }
    
    override func draw(_ rect: CGRect) {
//        let context = UIGraphicsGetCurrentContext()
//        let ship = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
//        context?.setFillColor(UIColor.blue.cgColor)
//        context?.addRect(ship)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
