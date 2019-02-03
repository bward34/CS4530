//
//  ClockView.swift
//  Project2
//
//  Created by Brandon Ward on 2/2/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class ClockView: UIView {
    var touchPoint: CGPoint = CGPoint(x: 0.0, y: 0.0)
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch: UITouch = touches.first!
        touchPoint = touch.location(in: self)
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let faceRect: CGRect = CGRect(x: 10.0, y: 10.0 + bounds.height * 0.5 - bounds.width * 0.5, width: bounds.width - 20.0, height: bounds.width - 20.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.addEllipse(in: faceRect)
        context.setLineWidth(5.0)
        context.setStrokeColor(UIColor.blue.cgColor)
        context.setFillColor(UIColor.darkGray.cgColor)
        context.drawPath(using: .fillStroke)
        
     //   let circle: CGRect = CGRect(x: touchPoint.x - 5.0, y: touchPoint.y - 5.0, width: 10.0, height: 10.0)
      //  context.addEllipse(in: circle)
        
        let radius = bounds.width / 2
        for i in stride(from: 360.0, through: 0.0, by: -30.0) {
            
            let x = radius * (sin(CGFloat(i) * 0.0174533)) + faceRect.midX
            let y = radius * (cos(CGFloat(i) * 0.0174533)) + faceRect.midY
            var dirX : CGFloat = 1.0
            var dirY : CGFloat = 1.0
            
            if(x < 0) {
                dirX = dirX * -1.0
            }
            if(y < 0) {
                dirY = dirY * -1.0
            }
            
            let moveX = ((radius - 12.0 * dirX) * (sin(CGFloat(i) * 0.0174533))) + faceRect.midX
            let moveY = ((radius - 12.0 * dirY) * (cos(CGFloat(i) * 0.0174533))) + faceRect.midY
            
            let drawPath : UIBezierPath = UIBezierPath()
            drawPath.move(to: CGPoint(x: x, y: y))
            drawPath.addLine(to: CGPoint(x: moveX, y: moveY))
            drawPath.lineWidth = 1.0
            UIColor.red.setStroke()
            drawPath.stroke()
        }
        
        //let faceCenter: CGPoint = CGPoint(x: faceRect.midX, y: faceRect.midY)
    
        
        // TODO: CALC minutehand from angle, radius, cos/sin from wiki
        // let faceCenter: CGPoint = CGPoint(x: faceRect.midX, y: faceRect.midY)
        
        
    }
}
