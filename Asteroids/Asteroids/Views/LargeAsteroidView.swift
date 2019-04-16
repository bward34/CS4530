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
        backgroundColor = UIColor.clear
        isOpaque = false
    }
    
    override func draw(_ rect: CGRect) {
        
        let drawPath : UIBezierPath = UIBezierPath()
        drawPath.move(to: CGPoint(x: rect.origin.x + rect.width * 0.05, y: rect.origin.y + 20))
        drawPath.addLine(to: CGPoint(x: rect.origin.x + rect.width * 0.75, y: rect.origin.y + 2))
        drawPath.move(to: CGPoint(x: rect.origin.x + rect.width * 0.75, y: rect.origin.y + 2))
        drawPath.addLine(to: CGPoint(x: rect.origin.x + rect.width - 2, y: rect.origin.y + 35))
        drawPath.move(to: CGPoint(x: rect.origin.x + rect.width - 2, y: rect.origin.y + 35))
        drawPath.addLine(to: CGPoint(x: rect.origin.x + rect.width * 0.95, y: rect.origin.y + rect.height * 0.9))
        drawPath.move(to: CGPoint(x: rect.origin.x + rect.width * 0.95, y: rect.origin.y + rect.height * 0.9))
        drawPath.addLine(to: CGPoint(x: rect.origin.x + rect.width * 0.75, y: rect.origin.y + rect.height * 0.65))
        drawPath.move(to: CGPoint(x: rect.origin.x + rect.width * 0.75, y: rect.origin.y + rect.height * 0.65))
        drawPath.addLine(to: CGPoint(x: rect.origin.x + rect.width * 0.68, y: rect.origin.y + rect.height * 0.85))
        drawPath.move(to: CGPoint(x: rect.origin.x + rect.width * 0.68, y: rect.origin.y + rect.height * 0.85))
        drawPath.addLine(to: CGPoint(x: rect.origin.x + rect.width * 0.55, y: rect.origin.y + rect.height - 2))
        drawPath.move(to: CGPoint(x: rect.origin.x + rect.width * 0.55, y: rect.origin.y + rect.height - 2))
        drawPath.addLine(to: CGPoint(x: rect.origin.x + rect.width * 0.15, y: rect.origin.y + rect.height * 0.9))
        drawPath.move(to: CGPoint(x: rect.origin.x + rect.width * 0.15, y: rect.origin.y + rect.height * 0.9))
        drawPath.addLine(to: CGPoint(x: rect.origin.x + rect.width * 0.05, y: rect.origin.y + rect.height * 0.75))
        drawPath.move(to: CGPoint(x: rect.origin.x + rect.width * 0.05, y: rect.origin.y + rect.height * 0.75))
        drawPath.addLine(to: CGPoint(x: rect.origin.x + 2, y: rect.origin.y + 50))
        drawPath.move(to: CGPoint(x: rect.origin.x + 2, y: rect.origin.y + 50))
        drawPath.addLine(to: CGPoint(x: rect.origin.x + rect.width * 0.05, y: rect.origin.y + 20))
        drawPath.lineWidth = 3.0
        drawPath.lineCapStyle = .round
        UIColor(hue: 0.1, saturation: 1, brightness: 1, alpha: 1.0) .setStroke()
      //  UIColor(hue: 0.0917, saturation: 1, brightness: 0.7, alpha: 1.0).setStroke()
        drawPath.stroke()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
