//
//  ClockView.swift
//  Time
//
//  Created by Brandon Ward on 1/23/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class ClockView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let faceRect: CGRect = CGRect(x: 0.0, y: bounds.height * 0.5 - bounds.width * 0.5, width: bounds.width, height: bounds.width)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.addRect(faceRect)
        context.drawPath(using: .fill)
    }
}
