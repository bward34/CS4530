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
    
    private var GMT_START_HOUR = 0
    private var NEW_HOUR : Int = 0
    private var GMT_AMPM : Int8 = 0
    private var CURR_AMPM : Int8 = 0
    private var PREV_AMPM : Int8 = 0
    private var CURR_QUAD : Int = 0
    private var PREV_QUAD : Int = 0
    private var CURR_HOUR : Int = 0
    private var CLOCKWISE : Int = 0
    private var DIFF_GMT : Int = 0
    private var timeZoneName : String = "Greenwich Mean Time"
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        calender.timeZone = TimeZone(secondsFromGMT: 0)!
        
        GMT_START_HOUR = calender.component(.hour, from: date)
        //GMT_START_HOUR = 12
        secondAngle = (CGFloat(calender.component(.second, from: date)) * 6.0) * .pi/180
        minuteAngle = (CGFloat(calender.component(.minute, from: date)) * 6.0) * .pi/180

        
        GMT_START_HOUR = GMT_START_HOUR > 12 ? GMT_START_HOUR - 12 : GMT_START_HOUR
        NEW_HOUR = GMT_START_HOUR
        CURR_AMPM = GMT_START_HOUR > 12 ? 1 : 0
        
        
        angle = (CGFloat(GMT_START_HOUR) * 30.0) * .pi/180
        CURR_QUAD = getQuadrant(angle: Double(angle))

        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(calculateTime), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        PREV_AMPM = CURR_AMPM
        CURR_HOUR = NEW_HOUR
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        touchPoint = touch.location(in: self)
        let point : CGPoint = CGPoint(
            x: touchPoint.x - faceRect.midX,
            y: touchPoint.y - faceRect.midX
        )
        
        angle = atan2(point.y, point.x) + .pi/2
        PREV_QUAD = CURR_QUAD
        CURR_QUAD = getQuadrant(angle: Double(angle))
        
        updateAngle()
        
        //Determines AM/PM
        if((CURR_QUAD == 1 && PREV_QUAD == 2) || (CURR_QUAD == 2 && PREV_QUAD == 1)) {
            CURR_AMPM = CURR_AMPM == 1 ? 0 : 1
        }
        
        //Get direction of movement base on quadrant
        if(CURR_QUAD == 4 && PREV_QUAD == 1) {
            CLOCKWISE += 1
        }
        else if(CURR_QUAD == 1 && PREV_QUAD == 4 ) {
            CLOCKWISE -= 1
        }
        else if(CURR_QUAD < PREV_QUAD) {
            CLOCKWISE += 1
        }
        else if(CURR_QUAD > PREV_QUAD) {
            CLOCKWISE -= 1
        }
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("this is new houe \(NEW_HOUR)")
        var offset : Int = 0
        
        if(CURR_AMPM == PREV_AMPM) {
            if(CURR_HOUR == 12 && NEW_HOUR == 12 ) {
                offset = 0
            }
            else if(CURR_HOUR == 12) {
                offset = NEW_HOUR
            }
            else if(NEW_HOUR == 12 && CURR_HOUR < 12) {
                offset = (12 - (NEW_HOUR - CURR_HOUR)) * -1
            }
            else if(NEW_HOUR > CURR_HOUR) {
                offset = NEW_HOUR - CURR_HOUR
            }
            else if(CURR_HOUR > NEW_HOUR) {
                offset = (CURR_HOUR - NEW_HOUR) * -1
            }
        }
        else {
            if(CURR_HOUR == 12 && CLOCKWISE < 0) { //counter and 12
                offset = (12 - NEW_HOUR) * -1
            }
            else if(CURR_HOUR == 12 && CLOCKWISE > 0) { // clockwise and 12
                offset = 12 - NEW_HOUR
            }
            else if(NEW_HOUR == 12 && CURR_HOUR < 12 ) {
                offset = 12 - CURR_HOUR
            }
            else if(CLOCKWISE > 0) {
                offset = (12 - CURR_HOUR) + NEW_HOUR
            }
            else if(CLOCKWISE < 0) {
                offset = ((12 - NEW_HOUR) + CURR_HOUR) * -1
            }
        }
        
        DIFF_GMT += offset
        
        //Resets the offsets
        if(DIFF_GMT > 12) {
            if(NEW_HOUR < 12) {
                DIFF_GMT = NEW_HOUR > GMT_START_HOUR ? (12 - (NEW_HOUR - GMT_START_HOUR)) * -1 : (GMT_START_HOUR - NEW_HOUR) * -1
            }
            else if(NEW_HOUR == 12){
                DIFF_GMT = GMT_START_HOUR != 11 ? (12 - GMT_START_HOUR) * -1 : 1
            }
            else {
                DIFF_GMT = (GMT_START_HOUR - NEW_HOUR) * -1
            }

        }
        else if(DIFF_GMT < -11) {
            if(GMT_AMPM == 1 && PREV_AMPM == 1) {
                DIFF_GMT = GMT_START_HOUR
            }
            else if(NEW_HOUR < 12 && CURR_AMPM == PREV_AMPM) {
                DIFF_GMT = (GMT_START_HOUR - NEW_HOUR) * -1
            }
            else {
                DIFF_GMT = (12 + (DIFF_GMT + 12))
                if(DIFF_GMT == 12) {
                    DIFF_GMT = 0
                }
            }
        }
        CLOCKWISE = 0
        updateTimeZoneLabel()
        print("this is the offset \(DIFF_GMT)")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let radius = bounds.width / 2
        let phaseShift : CGFloat = .pi/2
        
        //print("bounds.width: \(bounds.width)")
        //print("bounds.height: \(bounds.height)")
        
        faceRect = CGRect(x: 0.0, y: 0.0, width: bounds.width, height: bounds.width)
        faceRect.origin.y = (bounds.height - faceRect.height) / 2.0
        
        var faceCenter : CGRect = CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0)
        faceCenter.origin.y = (bounds.height - faceCenter.height) / 2.0
        faceCenter.origin.x = (bounds.width - faceCenter.width) / 2.0
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        context.addEllipse(in: faceRect)
        context.setLineWidth(3.0)
        context.setStrokeColor(UIColor.black.cgColor)
        context.setFillColor(UIColor(red: 0.65, green: 0.674, blue: 0.686, alpha: 1.0).cgColor)
        context.drawPath(using: .fillStroke)
        
        
        for i in stride(from: 360.0, through: 0.0, by: -30.0) {
            
            let x = (radius - 10.0) * (sin(CGFloat(i) * 0.0174533)) + faceRect.midX
            let y = (radius - 10.0) * (cos(CGFloat(i) * 0.0174533)) + faceRect.midY
            var dirX : CGFloat = 1.0
            var dirY : CGFloat = 1.0
            
            if(x < 0) {
                dirX = dirX * -1.0
            }
            if(y < 0) {
                dirY = dirY * -1.0
            }
            
            let moveX = (((radius * 0.75) * dirX) * (sin(CGFloat(i) * 0.0174533))) + faceRect.midX
            let moveY = (((radius * 0.75) * dirY) * (cos(CGFloat(i) * 0.0174533))) + faceRect.midY
            
            let drawPath : UIBezierPath = UIBezierPath()
            drawPath.move(to: CGPoint(x: x, y: y))
            drawPath.addLine(to: CGPoint(x: moveX, y: moveY))
            drawPath.lineWidth = 5.0
            drawPath.lineCapStyle = .round
            UIColor.black.setStroke()
            drawPath.stroke()
        }
        
        let secondHand : UIBezierPath = UIBezierPath()
        secondHand.move(to: CGPoint(x: faceRect.midX, y: faceRect.midY))
        secondHand.addLine(to: CGPoint(x: (radius * 0.8) * ((cos(secondAngle - phaseShift)))  + faceRect.midX, y: (radius * 0.8) * (sin(secondAngle - phaseShift)) + faceRect.midY))
        secondHand.lineWidth = 2.0
        secondHand.lineCapStyle = .round
        UIColor.white.setStroke()
        secondHand.stroke()
        
        let minuteHand : UIBezierPath = UIBezierPath()
        minuteHand.move(to: CGPoint(x: faceRect.midX, y: faceRect.midY))
        minuteHand.addLine(to: CGPoint(x: (radius * 0.6) * ((cos(minuteAngle - phaseShift)))  + faceRect.midX, y: (radius * 0.6) * (sin(minuteAngle - phaseShift)) + faceRect.midY))
        minuteHand.lineWidth = 5.0
        minuteHand.lineCapStyle = .round
        UIColor(red: 0.372, green: 0.376, blue: 0.384, alpha: 1.0).setStroke()
        minuteHand.stroke()
        
        let hourHand : UIBezierPath = UIBezierPath()
        hourHand.move(to: CGPoint(x: faceRect.midX, y: faceRect.midY))
        hourHand.addLine(to: CGPoint(x: (radius * 0.78) * ((cos(angle - phaseShift)))  + faceRect.midX, y: (radius * 0.78) * (sin(angle - phaseShift)) + faceRect.midY))
        hourHand.lineWidth = 5.0
        hourHand.lineCapStyle = .round
        UIColor(red: 0.0, green: 0.298, blue: 0.329, alpha: 1.0).setStroke()
        hourHand.stroke()
        
        context.addEllipse(in: faceCenter)
        context.setFillColor(UIColor.black.cgColor)
        context.drawPath(using: .fill)
        
    }
    
    @objc func calculateTime() {
        let date = Date()
        
        var calender = Calendar.current
        let day = Calendar.current
        calender.timeZone = TimeZone(secondsFromGMT: 0)!
        GMT_START_HOUR = calender.component(.hour, from: date)
        GMT_START_HOUR = GMT_START_HOUR > 12 ? GMT_START_HOUR - 12 : GMT_START_HOUR
        
        let minute = day.component(.minute, from: date)
        let seconds = day.component(.second, from: date)
        
        secondAngle = (CGFloat(seconds) * 6.0) * .pi/180
        minuteAngle = (CGFloat(minute) * 6.0) * .pi/180
        
        setNeedsDisplay()
    }
    
    func updateAngle() {
        
        let radian = angle > 0 ? angle * 180 / .pi : (270 + (90 + (angle  * 180 / .pi)))
        
        switch radian {
        case (0.0...29.99) :
            NEW_HOUR = 12
        case (30.0...59.99) :
            NEW_HOUR = 1
        case (60.0...89.99) :
            NEW_HOUR = 2
        case (90.0...119.99) :
            NEW_HOUR = 3
        case (120.0...149.99) :
            NEW_HOUR = 4
        case (150.0...179.99) :
            NEW_HOUR = 5
        case (180.0...209.99) :
            NEW_HOUR = 6
        case (210.0...239.99) :
            NEW_HOUR = 7
        case (240.0...269.99) :
            NEW_HOUR = 8
        case (270.0...299.99) :
            NEW_HOUR = 9
        case (300.0...329.99) :
            NEW_HOUR = 10
        case (330.0...360.0) :
            NEW_HOUR = 11
        default:
            NEW_HOUR = CURR_HOUR
        }
    }
    
    func getQuadrant(angle: Double) -> Int {
        var quadrant : Int = 0
        let convertedAngle = angle > 0 ? angle * 180 / .pi : (270 + (90 + (angle  * 180 / .pi)))
        switch convertedAngle {
        case (0.0...89.99):
            quadrant = 1
        case (90.0...179.99):
            quadrant = 4
        case (180.0...269.99):
            quadrant = 3
        case (270.0...359.99):
            quadrant = 2
        default:
            quadrant = 1
        }
        return quadrant
    }
    
    func updateTimeZoneLabel() {
        switch DIFF_GMT {
        case 0:
            timeZoneName = "Greenwich Mean Time"
        case 1:
            timeZoneName = "European Central Time"
        case 2:
            timeZoneName = "Eastern European Time"
        case 3:
            timeZoneName = "Eastern African Time"
        case 4:
            timeZoneName = "Near East Time"
        case 5:
            timeZoneName = "Pakistan Lahore Time"
        case 6:
            timeZoneName = "Bangladesh Standard Time"
        case 7:
            timeZoneName = "Vietnam Standard Time"
        case 8:
            timeZoneName = "China Taiwan Time"
        case 9:
            timeZoneName = "Japan Standard Time"
        case 10:
            timeZoneName = "Australia Eastern Time"
        case 11:
            timeZoneName = "Solomon Standard Time"
        case 12:
            timeZoneName = "New Zealand Standard Time"
        case -1:
            timeZoneName = "Central African Time"
        case -2:
            timeZoneName = "America/Noronha Time"
        case -3:
            timeZoneName = "Argentina Standard Time"
        case -4:
            timeZoneName = "US Virgin Islands Time"
        case -5:
            timeZoneName = "Eastern Standard Time"
        case -6:
            timeZoneName = "Central Standard Time"
        case -7:
            timeZoneName = "Mountain Standard Time"
        case -8:
            timeZoneName = "Pacific Standard Time"
        case -9:
            timeZoneName = "Alaska Standard Time"
        case -10:
            timeZoneName = "Hawaii Standard Time"
        case -11:
            timeZoneName = "Midway Islands Time"
        default:
            timeZoneName = "Greenwich Mean Time"
        }
    }
    
    func getTimeZoneLabel() -> String {
        return timeZoneName
    }
    
    func getOffSet() -> Int {
        return DIFF_GMT
    }
    
    
}
