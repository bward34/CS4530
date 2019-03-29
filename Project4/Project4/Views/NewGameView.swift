//
//  NewGameView.swift
//  Project3 - Project4
//
//  Created by Brandon Ward on 3/22/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class NewGameView: UIView {
    
    var newGameLabel : UILabel
    var gameNameLabel: UILabel
    var gameNameField: UITextField
    var playerNameLabel: UILabel
    var playerNameField: UITextField
    var backLabel : UIButton
    var createGame : UIButton
    
    override init(frame: CGRect) {
        playerNameLabel = UILabel()
        gameNameLabel = UILabel()
        gameNameField = UITextField()
        newGameLabel = UILabel()
        playerNameField = UITextField()
        backLabel = UIButton()
        createGame = UIButton()
        super.init(frame: frame)
        backgroundColor = .lightGray
    }
    
    override func draw(_ rect: CGRect) {
        
        backLabel.setTitle("←HOME", for: .normal)
        backLabel.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 20)
        backLabel.backgroundColor = .blue
        backLabel.frame = CGRect(x: frame.origin.x + 5.0, y: frame.origin.y + 20.0, width: 75.0, height: 25.0)
        
        newGameLabel.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.1, width: 200, height: 50)
        newGameLabel.text = "New Game"
        newGameLabel.textAlignment = NSTextAlignment.center
        newGameLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 35)
        newGameLabel.textColor = .white
        
        gameNameLabel.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.18, width: 200, height: 50)
        gameNameLabel.text = "Enter a game name:"
        gameNameLabel.textAlignment = NSTextAlignment.center
        gameNameLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 15)
        gameNameLabel.textColor = .white
        
        
        gameNameField.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.25, width: 200.0, height: 25.0)
        gameNameField.backgroundColor = UIColor.white
        
        playerNameLabel.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.28, width: 200, height: 50)
        playerNameLabel.text = "Enter your name:"
        playerNameLabel.textAlignment = NSTextAlignment.center
        playerNameLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 15)
        playerNameLabel.textColor = .white
        

        playerNameField.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.35, width: 200.0, height: 25.0)
        playerNameField.backgroundColor = UIColor.white
        
        createGame.setTitle("Create Game", for: .normal)
        createGame.backgroundColor = .green
        createGame.frame = CGRect(x: (frame.width / 2.0) - (175.0 / 2.0), y: frame.height * 0.45, width: 175.0, height: 45.0)
        
        addSubview(backLabel)
        addSubview(newGameLabel)
        addSubview(gameNameLabel)
        addSubview(gameNameField)
        addSubview(playerNameLabel)
        addSubview(playerNameField)
        addSubview(createGame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
