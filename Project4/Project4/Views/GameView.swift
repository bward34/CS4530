//
//  GameView.swift
//  Project3 - Project4
//
//  Created by Brandon Ward on 2/28/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

protocol GameViewDelegate {
    func gameView(_ gameView: GameView, currentPlayerTokens col: Int, and row: Int) -> String
    func gameView(_ gameView: GameView, otherPlayerTokens col: Int, and row: Int) -> String
    func gameView(_ gameView: GameView, cellTouchedAt col: Int, and row: Int)
    func gameView(_ gameView: GameView)
}

class GameView: UIView {
    
    var backLabel : UIButton
    var infoLabel : UILabel
    
    /**
     The board that the other player is playing on. The is the current users
     ships. Displays ships with hits and misses.
     */
    var currentPlayerBoard: CGRect = CGRect()
    /**
     The board that the current player plays on. This contains no
     ships, only hits and misses.
     */
    var otherPlayerBoard: CGRect = CGRect()
    var dataSource: GameViewDelegate?
    var isPortrait : Bool = true
    
    override init(frame: CGRect) {
        backLabel = UIButton()
        infoLabel = UILabel()
        super.init(frame: frame)
        backLabel.addTarget(self, action: #selector(goHome), for: UIControl.Event.touchUpInside)
        backgroundColor = UIColor.lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        backLabel.setTitle("←HOME", for: .normal)
        backLabel.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 20)
        backLabel.backgroundColor = .blue
        backLabel.layer.cornerRadius = 5
        backLabel.layer.borderColor = UIColor.white.cgColor
        backLabel.layer.borderWidth = 1
        backLabel.frame = CGRect(x: frame.origin.x + 5.0, y: frame.origin.y + 20.0, width: 75.0, height: 25.0)
        addSubview(backLabel)
        
        infoLabel.frame = CGRect(x: frame.midX - 100, y: frame.origin.y + 10.0, width: 200, height: 50)
        infoLabel.textAlignment = NSTextAlignment.center
        infoLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 15)
        infoLabel.textColor = .white
        addSubview(infoLabel)
        
        //Draw grid lines
        let context = UIGraphicsGetCurrentContext()
        var ratio : CGFloat = 0.0
        if isPortrait {
            ratio = frame.width > 500 ? 0.5 : 0.3
            currentPlayerBoard = CGRect(x: frame.midX, y: frame.midY, width: frame.width - (frame.width * ratio), height: frame.width - (frame.width * ratio))
            currentPlayerBoard.origin.y = ((frame.height - currentPlayerBoard.height) / 2.0) * 1.8
            currentPlayerBoard.origin.x = (frame.width - currentPlayerBoard.width) / 2.0
        }
        else {
            ratio = frame.height > 500 ? 0.5 : 0.3
            currentPlayerBoard = CGRect(x: frame.midX, y: frame.midY, width: frame.height - (frame.height * ratio), height: frame.height - (frame.height * ratio))
            currentPlayerBoard.origin.y = ((frame.height - currentPlayerBoard.height) / 2.0)
            currentPlayerBoard.origin.x = ((frame.width - currentPlayerBoard.width) / 2.0) * 1.8
        }
        
        
        context?.addRect(currentPlayerBoard)
        context?.setLineWidth(1.0)
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.setFillColor(UIColor.darkGray.cgColor)
        context?.drawPath(using: .fillStroke)
        
        if isPortrait {
            ratio = frame.width > 500 ? 0.5 : 0.3
            otherPlayerBoard = CGRect(x: frame.midX, y: frame.midY, width: frame.width - (frame.width * ratio), height: frame.width - (frame.width * ratio))
            otherPlayerBoard.origin.y = ((frame.height - otherPlayerBoard.height) / 2.0) * 0.3
            otherPlayerBoard.origin.x = (frame.width - otherPlayerBoard.width) / 2.0
        }
        else
        {
            ratio = frame.height > 500 ? 0.5 : 0.3
            otherPlayerBoard = CGRect(x: frame.midX, y: frame.midY, width: frame.height - (frame.height * ratio), height: frame.height - (frame.height * ratio))
            otherPlayerBoard.origin.y = ((frame.height - otherPlayerBoard.height) / 2.0)
            otherPlayerBoard.origin.x = ((frame.width - otherPlayerBoard.width) / 2.0) * 0.3
        }
        
        context?.addRect(otherPlayerBoard)
        context?.setLineWidth(1.0)
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.setFillColor(UIColor.blue.cgColor)
        context?.drawPath(using: .fillStroke)

        var percentage : CGFloat = 0.0
        while percentage < 1.0 {
            
            let currStartX_ROW : CGFloat = currentPlayerBoard.origin.x
            let currStartY_ROW : CGFloat = currentPlayerBoard.origin.y + (currentPlayerBoard.height * percentage)
            let currEndX_ROW : CGFloat = currentPlayerBoard.width + currentPlayerBoard.origin.x
            let currEndY_ROW : CGFloat = currentPlayerBoard.origin.y + (currentPlayerBoard.height * percentage)
            
            let otherStartX_ROW : CGFloat = otherPlayerBoard.origin.x
            let otherStartY_ROW : CGFloat = otherPlayerBoard.origin.y + (otherPlayerBoard.height * percentage)
            let otherEndX_ROW : CGFloat = otherPlayerBoard.width + otherPlayerBoard.origin.x
            let otherEndY_ROW : CGFloat = otherPlayerBoard.origin.y + (otherPlayerBoard.height * percentage)
            
            let currStartX_COL : CGFloat = currentPlayerBoard.origin.x + (currentPlayerBoard.width * percentage)
            let currStartY_COL : CGFloat = currentPlayerBoard.origin.y
            let currEndX_COL : CGFloat = currentPlayerBoard.origin.x + (currentPlayerBoard.width * percentage)
            let currEndY_COL : CGFloat = currentPlayerBoard.height + currentPlayerBoard.origin.y
            
            let otherStartX_COL : CGFloat = otherPlayerBoard.origin.x + (otherPlayerBoard.width * percentage)
            let otherStartY_COL : CGFloat = otherPlayerBoard.origin.y
            let otherEndX_COL : CGFloat = otherPlayerBoard.origin.x + (otherPlayerBoard.width * percentage)
            let otherEndY_COL : CGFloat = otherPlayerBoard.height + otherPlayerBoard.origin.y
            
            //Add rows for both boards
            context?.move(to: CGPoint(x: currStartX_ROW, y: currStartY_ROW))
            context?.addLine(to: CGPoint(x: currEndX_ROW, y: currEndY_ROW))
            context?.move(to: CGPoint(x: otherStartX_ROW, y: otherStartY_ROW))
            context?.addLine(to: CGPoint(x: otherEndX_ROW, y: otherEndY_ROW))
            
            //Add cols for both boards
            context?.move(to: CGPoint(x: currStartX_COL, y: currStartY_COL))
            context?.addLine(to: CGPoint(x: currEndX_COL, y: currEndY_COL))
            context?.move(to: CGPoint(x: otherStartX_COL, y: otherStartY_COL))
            context?.addLine(to: CGPoint(x: otherEndX_COL, y: otherEndY_COL))
            
            percentage += 0.1
        }

        context?.setStrokeColor(UIColor.white.cgColor)
        context?.drawPath(using: .stroke)
        
        
        if let dataSource = dataSource {
        //Fills bottom board
        for col in 0 ..< 10 {
            for row in 0 ..< 10 {

                let x = (CGFloat(col) + 0.25) * 0.1 * currentPlayerBoard.width + currentPlayerBoard.origin.x
                let y = (CGFloat(row) + 0.25) * 0.1 * currentPlayerBoard.height + currentPlayerBoard.origin.y
                let point : CGPoint = CGPoint(x: x, y: y)
                let cell = dataSource.gameView(self, currentPlayerTokens: col, and: row)
                cell.draw(at: point, withAttributes: nil)
                }
            }
        //Fills top board -> board being played on
        for col in 0 ..< 10 {
                for row in 0 ..< 10 {
                    
                    let x = (CGFloat(col) + 0.25) * 0.1 * otherPlayerBoard.width + otherPlayerBoard.origin.x
                    let y = (CGFloat(row) + 0.25) * 0.1 * otherPlayerBoard.height + otherPlayerBoard.origin.y
                    let point : CGPoint = CGPoint(x: x, y: y)
                    let cell = dataSource.gameView(self, otherPlayerTokens: col, and: row)
                    cell.draw(at: point, withAttributes: nil)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: self)
        if otherPlayerBoard.contains(touchPoint) {
            let col: Int = Int((touchPoint.x - otherPlayerBoard.origin.x) / (otherPlayerBoard.width / 10.0))
            let row: Int = Int((touchPoint.y - otherPlayerBoard.origin.y) / (otherPlayerBoard.height / 10.0))
            
            dataSource?.gameView(self, cellTouchedAt: col, and: row)
        }
    }
    
    @objc func goHome() {
        dataSource?.gameView(self)
    }
}
