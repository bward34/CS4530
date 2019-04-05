//
//  GameView.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/4/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class GameView : UIView {
    
    var rotateLeftButton : UIButton
    var rotateRightButton : UIButton
    var accelerateButton : UIButton
    
    var ship: ShipView
    
    override init(frame: CGRect) {
        rotateLeftButton = UIButton()
        rotateRightButton = UIButton()
        accelerateButton = UIButton()
        ship = ShipView()
        super.init(frame : frame)
        backgroundColor = .gray
    }
    
    override func draw(_ rect: CGRect) {
        ship.frame = CGRect(x: frame.midX, y: frame.midY, width: 30.0, height: 30.0)
        
        accelerateButton.frame = CGRect(x: frame.width, y: frame.height, width: 30.0, height: 30.0)
        accelerateButton.setTitle("Acclerate", for: .normal)
        addSubview(ship)
    }
    
    func reloadData() {
        setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
