//
//  GameView.swift
//  TicTacToe
//
//  Created by Brandon Ward on 2/20/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

protocol GameViewDelegate {
    func gameView(_gameView: GameView, tokenFor col: Int, and row: Int) -> String
    func gameView(_gameView: GameView, cellTouchedAt col: Int, and row: Int)
}

class GameView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    var cells: [[String]] {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
    
    var delegate: GameViewDelegate
    
    func reloadData() {
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        //TODO: Draw grid
        
        //TODO: fill each cell with X or O depending on the player who claimed that cell, by reading the cell array
        let tokken00 = delegate.gameView(_gameView: self, tokenFor: 0, and: 0)
        //(cells[0][0] as NSString).draw(in: CGRect, withAttributes: [ns])
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
