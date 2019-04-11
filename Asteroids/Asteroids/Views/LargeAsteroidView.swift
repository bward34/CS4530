//
//  LargeAsteroidView.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/11/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class LargeAsteroidView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    override func draw(_ rect: CGRect) {
        
        let drawPath : UIBezierPath = UIBezierPath()
        drawPath.move(to: CGPoint(x: rect.origin.x, y: rect.origin.y))
        drawPath.addLine(to: CGPoint(x: rect.origin.x + rect.height, y: rect.origin.y))
        
        drawPath.lineWidth = 2.0
        drawPath.lineCapStyle = .round
        UIColor(hue: 0.3194, saturation: 1, brightness: 1, alpha: 1.0).setStroke()
        drawPath.stroke()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
