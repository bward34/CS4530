//
//  JoinGameView.swift
//  Project4
//
//  Created by Brandon Ward on 3/26/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class JoinGameView: UIView {
    
    var newGameLabel : UILabel
    var playerNameLabel: UILabel
    var playerNameField: UITextField
    var backLabel : UIButton
    var joinGame : UIButton
    
    override init(frame: CGRect) {
        playerNameLabel = UILabel()
        newGameLabel = UILabel()
        playerNameField = UITextField()
        backLabel = UIButton()
        joinGame = UIButton()
        super.init(frame: frame)
        backgroundColor = .lightGray
    }
    
    override func draw(_ rect: CGRect) {
        
        backLabel.setTitle("←HOME", for: .normal)
        backLabel.backgroundColor = .blue
        backLabel.frame = CGRect(x: frame.origin.x + 5.0, y: frame.origin.y + 20.0, width: 75.0, height: 25.0)
        
        newGameLabel.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.1, width: 200, height: 50)
        newGameLabel.text = "Join Game"
        newGameLabel.textAlignment = NSTextAlignment.center
        newGameLabel.font = UIFont(name: "HelveticaNeue", size: 35)
        newGameLabel.textColor = .white
        
        playerNameLabel.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.28, width: 200, height: 50)
        playerNameLabel.text = "Enter your name:"
        playerNameLabel.textAlignment = NSTextAlignment.center
        playerNameLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        playerNameLabel.textColor = .white
        
        
        playerNameField.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.35, width: 200.0, height: 25.0)
        playerNameField.backgroundColor = UIColor.white
        
        joinGame.setTitle("Join Game", for: .normal)
        joinGame.backgroundColor = .green
        joinGame.frame = CGRect(x: (frame.width / 2.0) - (175.0 / 2.0), y: frame.height * 0.45, width: 175.0, height: 45.0)
        
        addSubview(backLabel)
        addSubview(newGameLabel)
        addSubview(playerNameLabel)
        addSubview(playerNameField)
        addSubview(joinGame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

