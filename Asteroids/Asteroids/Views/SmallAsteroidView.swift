//
//  SmallAsteroidView.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/15/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class SmallAsteroidView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor.clear
        isOpaque = false
    }
    
    override func draw(_ rect: CGRect) {
        
        let drawPath : UIBezierPath = UIBezierPath()
        drawPath.move(to: CGPoint(x: rect.midX, y: rect.origin.y + 2))
        drawPath.addLine(to: CGPoint(x: rect.midX + rect.midX * 0.5, y: rect.origin.y + 10))
        drawPath.move(to: CGPoint(x: rect.midX + rect.midX * 0.5, y: rect.origin.y + 10))
        drawPath.addLine(to: CGPoint(x: rect.width - 2, y: rect.width * 0.33))
        drawPath.move(to: CGPoint(x: rect.width - 2, y: rect.height * 0.33))
        drawPath.addLine(to: CGPoint(x: rect.width - 2, y: rect.height * 0.66))
        drawPath.move(to: CGPoint(x: rect.width - 2, y: rect.height * 0.66))
        drawPath.addLine(to: CGPoint(x: rect.width * 0.75, y: rect.height - 2))
        drawPath.move(to: CGPoint(x: rect.width * 0.75, y: rect.height - 2))
        drawPath.addLine(to: CGPoint(x: rect.width * 0.35, y: rect.height - 10))
        drawPath.move(to: CGPoint(x: rect.width * 0.35, y: rect.height - 10))
        drawPath.addLine(to: CGPoint(x: rect.width * 0.25, y: rect.height - 5))
        drawPath.move(to: CGPoint(x: rect.width * 0.25, y: rect.height - 5))
        drawPath.addLine(to: CGPoint(x: rect.origin.x + 2, y: rect.height * 0.7))
        drawPath.move(to: CGPoint(x: rect.origin.x + 2, y: rect.height * 0.7))
        drawPath.addLine(to: CGPoint(x: rect.origin.x + 2, y: rect.height * 0.4))
        drawPath.move(to: CGPoint(x: rect.origin.x + 2, y: rect.height * 0.4))
        drawPath.addLine(to: CGPoint(x: rect.midX, y: rect.origin.y + 2))
        drawPath.lineWidth = 3.0
        drawPath.lineCapStyle = .round
        UIColor(hue: 0.1, saturation: 1, brightness: 1, alpha: 1.0) .setStroke()
       // UIColor(hue: 0.0917, saturation: 1, brightness: 0.7, alpha: 1.0).setStroke()
        drawPath.stroke()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
