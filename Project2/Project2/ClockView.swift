//
//  ClockView.swift
//  Project2
//
//  Created by Brandon Ward on 2/2/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class ClockView: UIView {
    
    private var faceRect : CGRect = CGRect.zero
    private var touchPoint: CGPoint = CGPoint(x: 0.0, y: 0.0)
    private var angle : CGFloat = 0.0
    private var secondAngle : CGFloat = 0.0
    private var minuteAngle : CGFloat = 0.0
    
    private var date = Date()
    var calender = Calendar.current
    
    
    let time : TimeInterval = 3600
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        calender.timeZone = TimeZone(secondsFromGMT: 0)!
        let hour = calender.component(.hour, from: date)
        let minute = calender.component(.minute, from: date)
        let seconds = calender.component(.second, from: date)
        
        secondAngle = (CGFloat(seconds) * 6.0) * .pi/180
        minuteAngle = (CGFloat(minute) * 6.0) * .pi/180
        angle = (CGFloat(hour) * 30.0) * .pi/180
        
        print("this is the current time: \(hour)")
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(calculateTime), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesMoved(touches, with: event)
        let touch: UITouch = touches.first!
        touchPoint = touch.location(in: self)
        print("X: \(touchPoint.x) Y: \(touchPoint.y)")
        
        let point : CGPoint = CGPoint(
            x: touchPoint.x - faceRect.midX,
            y: touchPoint.y - faceRect.midX
        )
        
        print("Modified X: \(point.x) Y: \(point.y)")
        angle = atan2(point.y, point.x) + .pi/2
        print("Angle: \(angle * 180 / .pi)")
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let radius = bounds.width / 2
        let phaseShift : CGFloat = .pi/2
        
        print("bounds.width: \(bounds.width)")
        print("bounds.height: \(bounds.height)")
        
        faceRect = CGRect(x: 0.0, y: 0.0, width: bounds.width, height: bounds.width)
        faceRect.origin.y = (bounds.width - faceRect.width) / 2.0
        
        var faceCenter : CGRect = CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0)
        faceCenter.origin.y = (bounds.height - faceCenter.height) / 2.0
        faceCenter.origin.x = (bounds.width - faceCenter.width) / 2.0
        
        var hourHand : CGRect = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        hourHand.origin.x = faceRect.midX + (radius * 0.7) * cos(angle - phaseShift) - hourHand.width / 2.0
        hourHand.origin.y = faceRect.midY + (radius * 0.7) * sin(angle - phaseShift) - hourHand.height / 2.0
        
        var minuteHand : CGRect = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
        minuteHand.origin.x = faceRect.midX + (radius * 0.6) * cos(minuteAngle - phaseShift) - minuteHand.width / 2.0
        minuteHand.origin.y = faceRect.midY + (radius * 0.6) * sin(minuteAngle - phaseShift) - minuteHand.height / 2.0
        
        var secondHand : CGRect = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
        secondHand.origin.x = faceRect.midX + (radius * 0.9) * cos(secondAngle - phaseShift) - secondHand.width / 2.0
        secondHand.origin.y = faceRect.midY + (radius * 0.9) * sin(secondAngle - phaseShift) - secondHand.height / 2.0
        
        //var secondHand : CGRect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: faceRect.width * 0.45)
        //secondHand.origin.y = bounds.height / 2
        //secondHand.origin.x = (bounds.width - secondHand.width) / 2
        
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        context.addEllipse(in: faceRect)
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.blue.cgColor)
        context.setFillColor(UIColor.darkGray.cgColor)
        context.drawPath(using: .fillStroke)
        
        //context.addRect(secondHand)
        //context.setFillColor(UIColor.green.cgColor)
        //context.drawPath(using: .fill)
        
        context.addEllipse(in: faceCenter)
        context.setFillColor(UIColor.red.cgColor)
        context.drawPath(using: .fill)
        
        
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
            
            let moveX = ((radius - 35.0 * dirX) * (sin(CGFloat(i) * 0.0174533))) + faceRect.midX
            let moveY = ((radius - 35.0 * dirY) * (cos(CGFloat(i) * 0.0174533))) + faceRect.midY
            
            let drawPath : UIBezierPath = UIBezierPath()
            drawPath.move(to: CGPoint(x: x, y: y))
            drawPath.addLine(to: CGPoint(x: moveX, y: moveY))
            drawPath.lineWidth = 1.0
            UIColor.red.setStroke()
            drawPath.stroke()
        }
        
        context.addEllipse(in: secondHand)
        context.setFillColor(UIColor.purple.cgColor)
        context.drawPath(using: .fill)
        
        context.addEllipse(in: minuteHand)
        context.setFillColor(UIColor.yellow.cgColor)
        context.drawPath(using: .fill)
        
        context.addEllipse(in: hourHand)
        context.setFillColor(UIColor.green.cgColor)
        context.drawPath(using: .fill)
        
    }
    
    @objc func calculateTime() {
        let date = Date()
        let day = Calendar.current
        
        let minute = day.component(.minute, from: date)
        let seconds = day.component(.second, from: date)
        
        secondAngle = (CGFloat(seconds) * 6.0) * .pi/180
        minuteAngle = (CGFloat(minute) * 6.0) * .pi/180
        
        print("\(minute)")
        print("\(seconds)")
        setNeedsDisplay()
        print("Seconds angle: \(secondAngle)")
        print("Minutes angle: \(minuteAngle)")
    }
}
