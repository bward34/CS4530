//
//  YellowExplosionView.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/24/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class YellowExplosionView : UIView {
    
    var yellowRect : CGRect = CGRect.zero
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor.clear
        isOpaque = false
    }
    
    override func draw(_ rect: CGRect) {
        let context: CGContext = UIGraphicsGetCurrentContext()!
        yellowRect = CGRect(x: bounds.width * 0.1 , y: 0.0, width: bounds.width * 0.8, height: bounds.width * 0.8)
        yellowRect.origin.y = (bounds.height - yellowRect.height) / 2.0
        context.addEllipse(in: yellowRect)
        context.setStrokeColor(UIColor.yellow.cgColor)
        context.setLineWidth(3.0)
        context.drawPath(using: .stroke)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
