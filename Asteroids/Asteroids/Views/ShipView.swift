//
//  ShipView.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/4/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class ShipView : UIView {
    
    var shipExhaust : ShipExhaustView

    override init(frame: CGRect) {
        shipExhaust = ShipExhaustView()
        super.init(frame : .zero)
        backgroundColor = UIColor.clear
        isOpaque = false
    }
    
    override func draw(_ rect: CGRect) {
        
        let drawPath : UIBezierPath = UIBezierPath()
        drawPath.move(to: CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y))
        drawPath.addLine(to: CGPoint(x: rect.origin.x, y: rect.height))
        drawPath.lineWidth = 2.0
        drawPath.move(to: CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y))
        drawPath.addLine(to: CGPoint(x: rect.width, y: rect.height))
        drawPath.lineWidth = 2.0
        drawPath.move(to: CGPoint(x: rect.origin.x + rect.width / 2, y: rect.height - 8))
        drawPath.addLine(to: CGPoint(x: rect.width, y: rect.height))
        drawPath.move(to: CGPoint(x: rect.origin.x + rect.width / 2, y: rect.height - 8))
        drawPath.addLine(to: CGPoint(x: rect.origin.x, y: rect.height))
        drawPath.lineWidth = 2.0
        drawPath.lineCapStyle = .round
        UIColor(hue: 0.3194, saturation: 1, brightness: 1, alpha: 1.0).setStroke()
        drawPath.stroke()
        
        shipExhaust.bounds = CGRect(x: 0.0, y: 0.0, width: 15.0, height: 20.0)
        shipExhaust.center = CGPoint(x: rect.width / 2, y: rect.height - 2)
        addSubview(shipExhaust)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
