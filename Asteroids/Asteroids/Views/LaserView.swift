//
//  LaserView.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/18/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class LaserView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor.clear
        isOpaque = false
    }
    
    override func draw(_ rect: CGRect) {
        
        let drawPath : UIBezierPath = UIBezierPath()
        drawPath.move(to: CGPoint(x: rect.midX, y: rect.origin.y))
        drawPath.addLine(to: CGPoint(x: rect.midX, y: rect.height))
        drawPath.lineWidth = 2.0
        drawPath.lineCapStyle = .round
        UIColor.red.setStroke()
        drawPath.stroke()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
