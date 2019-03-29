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
        backLabel.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 20)
        backLabel.backgroundColor = .blue
        backLabel.frame = CGRect(x: frame.origin.x + 5.0, y: frame.origin.y + 20.0, width: 75.0, height: 25.0)
        //backLabel.translatesAutoresizingMaskIntoConstraints = false
        
        newGameLabel.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.1, width: 200, height: 50)
        newGameLabel.text = "Join Game"
        newGameLabel.textAlignment = NSTextAlignment.center
        newGameLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 35)
        newGameLabel.textColor = .white
        newGameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        playerNameLabel.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.28, width: 200, height: 50)
        playerNameLabel.text = "Enter your name:"
        playerNameLabel.textAlignment = NSTextAlignment.center
        playerNameLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 15)
        playerNameLabel.textColor = .white
        playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        playerNameField.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.35, width: 200.0, height: 25.0)
        playerNameField.backgroundColor = UIColor.white
        playerNameField.translatesAutoresizingMaskIntoConstraints = false
        
        joinGame.setTitle("Join Game", for: .normal)
        joinGame.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 20)
        joinGame.backgroundColor = .green
        joinGame.frame = CGRect(x: (frame.width / 2.0) - (175.0 / 2.0), y: frame.height * 0.45, width: 175.0, height: 45.0)
        joinGame.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backLabel)
        addSubview(newGameLabel)
        addSubview(playerNameLabel)
        addSubview(playerNameField)
        addSubview(joinGame)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[newGameLabel]-|", options: [], metrics: nil, views: ["newGameLabel": newGameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[playerNameLabel]-|", options: [], metrics: nil, views: ["playerNameLabel": playerNameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[playerNameField]-|", options: [], metrics: nil, views: ["playerNameField": playerNameField]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[joinGameButton]-|", options: [], metrics: nil, views: ["joinGameButton": joinGame]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[newGameLabel]-[playerNameLabel]-[playerNameField]-[joinGameButton]-(<=\(frame.width * 0.75))-|", options: [], metrics: nil, views: ["newGameLabel" : newGameLabel,"playerNameLabel" : playerNameLabel,"playerNameField": playerNameField, "joinGameButton" : joinGame]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

