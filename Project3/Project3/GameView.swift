//
//  GameView.swift
//  Project3
//
//  Created by Brandon Ward on 2/28/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

protocol GameViewDelegate {
    func gameView(_ gameView: GameView, cellFor col: Int, and row: Int) -> String
    func gameView(_ gameView: GameView, cellTouchedAt col: Int, and row: Int)
}

class GameView: UIView {
    
    var dataSource: GameViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //Draw grid lines
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x: 0, y: bounds.height * 0.1))
        context?.addLine(to: CGPoint(x: bounds.width, y: bounds.height * 0.1))
        context?.move(to: CGPoint(x: 0, y: bounds.height * 0.2))
        context?.addLine(to: CGPoint(x: bounds.width, y: bounds.height * 0.2))
        context?.move(to: CGPoint(x: 0, y: bounds.height * 0.3))
        context?.addLine(to: CGPoint(x: bounds.width, y: bounds.height * 0.3))
        context?.move(to: CGPoint(x: 0, y: bounds.height * 0.4))
        context?.addLine(to: CGPoint(x: bounds.width, y: bounds.height * 0.4))
        context?.move(to: CGPoint(x: 0, y: bounds.height * 0.4))
        context?.addLine(to: CGPoint(x: bounds.width, y: bounds.height * 0.4))
        context?.move(to: CGPoint(x: 0, y: bounds.height * 0.4))
        context?.addLine(to: CGPoint(x: bounds.width, y: bounds.height * 0.4))
        context?.move(to: CGPoint(x: 0, y: bounds.height * 0.5))
        context?.addLine(to: CGPoint(x: bounds.width, y: bounds.height * 0.5))
        context?.move(to: CGPoint(x: 0, y: bounds.height * 0.5))
        context?.addLine(to: CGPoint(x: bounds.width, y: bounds.height * 0.5))
        context?.move(to: CGPoint(x: 0, y: bounds.height * 0.6))
        context?.addLine(to: CGPoint(x: bounds.width, y: bounds.height * 0.6))
        context?.move(to: CGPoint(x: 0, y: bounds.height * 0.7))
        context?.addLine(to: CGPoint(x: bounds.width, y: bounds.height * 0.7))
        context?.move(to: CGPoint(x: 0, y: bounds.height * 0.8))
        context?.addLine(to: CGPoint(x: bounds.width, y: bounds.height * 0.8))
        context?.move(to: CGPoint(x: 0, y: bounds.height * 0.9))
        context?.addLine(to: CGPoint(x: bounds.width, y: bounds.height * 0.9))
    
        context?.move(to: CGPoint(x: bounds.width * 0.1, y: 0))
        context?.addLine(to: CGPoint(x: bounds.width * 0.1, y: bounds.height))
        context?.move(to: CGPoint(x: bounds.width * 0.2, y: 0))
        context?.addLine(to: CGPoint(x: bounds.width * 0.2, y: bounds.height))
        context?.move(to: CGPoint(x: bounds.width * 0.3, y: 0))
        context?.addLine(to: CGPoint(x: bounds.width * 0.3, y: bounds.height))
        context?.move(to: CGPoint(x: bounds.width * 0.4, y: 0))
        context?.addLine(to: CGPoint(x: bounds.width * 0.4, y: bounds.height))
        context?.move(to: CGPoint(x: bounds.width * 0.5, y: 0))
        context?.addLine(to: CGPoint(x: bounds.width * 0.5, y: bounds.height))
        context?.move(to: CGPoint(x: bounds.width * 0.6, y: 0))
        context?.addLine(to: CGPoint(x: bounds.width * 0.6, y: bounds.height))
        context?.move(to: CGPoint(x: bounds.width * 0.7, y: 0))
        context?.addLine(to: CGPoint(x: bounds.width * 0.7, y: bounds.height))
        context?.move(to: CGPoint(x: bounds.width * 0.8, y: 0))
        context?.addLine(to: CGPoint(x: bounds.width * 0.8, y: bounds.height))
        context?.move(to: CGPoint(x: bounds.width * 0.9, y: 0))
        context?.addLine(to: CGPoint(x: bounds.width * 0.9, y: bounds.height))
        
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.drawPath(using: .stroke)
        
        
        if let dataSource = dataSource {
        for row in 0 ..< 10 {
            for col in 0 ..< 10 {
                
                let cell = dataSource.gameView(self, cellFor: col, and: row)
                cell.draw(at: CGPoint(x: (CGFloat(col) + 0.5) * 0.1 * bounds.width, y: (CGFloat(row) + 0.5 ) * 0.1 * bounds.height), withAttributes: nil)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: self)
        
        let col: Int = Int(floor(fmax(0.0, fmin(9.0, touchPoint.x / bounds.width * 10.0))))
        let row: Int = Int(floor(fmax(0.0, fmin(9.0, touchPoint.x / bounds.width * 10.0))))
        
        dataSource?.gameView(self, cellTouchedAt: col, and: row)
    }
}
