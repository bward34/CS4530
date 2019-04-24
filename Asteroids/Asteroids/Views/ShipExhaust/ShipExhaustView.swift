//
//  ShipExhaustView.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/23/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class ShipExhaustView : UIView {
    
    var triangleExhaust : ShipExhaustTriangleView
    var lineExhaust : ShipExhaustLineView
    
    override init(frame: CGRect) {
        triangleExhaust = ShipExhaustTriangleView()
        lineExhaust = ShipExhaustLineView()
        super.init(frame : .zero)
        backgroundColor = UIColor.clear
        isOpaque = false
    }
    
    override func draw(_ rect: CGRect) {
        triangleExhaust.bounds = CGRect(x: 0.0, y: 0.0, width: 7.0, height: 15.0)
        triangleExhaust.center = CGPoint(x: rect.midX, y: rect.midY)
        lineExhaust.bounds = CGRect(x: 0.0, y: 0.0, width: 5.0, height: 15.0)
        lineExhaust.center = CGPoint(x: rect.midX, y: rect.midY)
        addSubview(triangleExhaust)
        addSubview(lineExhaust)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

