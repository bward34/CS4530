//
//  OrangeExplosionView.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/24/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class OrangeExplosionView : UIView {
    
    var orangeRect : CGRect = CGRect.zero
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor.clear
        isOpaque = false
    }
    
    override func draw(_ rect: CGRect) {
        let context: CGContext = UIGraphicsGetCurrentContext()!
        orangeRect = CGRect(x: bounds.width * 0.1 , y: 0.0, width: bounds.width * 0.8, height: bounds.width * 0.8)
        orangeRect.origin.y = (bounds.height - orangeRect.height) / 2.0
        context.addEllipse(in: orangeRect)
        context.setStrokeColor(UIColor.orange.cgColor)
        context.setLineWidth(3.0)
        context.drawPath(using: .stroke)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
