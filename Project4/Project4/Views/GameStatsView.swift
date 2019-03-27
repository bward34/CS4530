//
//  GameStatsView.swift
//  Project4
//
//  Created by Brandon Ward on 3/26/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class GameStatsView: UIView {
    
    var gameDetailLabel : UILabel
    var gameName : UILabel
    var idLabel: UILabel
    var player1: UILabel
    var player2 : UILabel
    var winner : UILabel
    var status : UILabel
    var missles : UILabel
    
    override init(frame: CGRect) {
        gameDetailLabel = UILabel()
        gameName = UILabel()
        idLabel = UILabel()
        player1 = UILabel()
        player2 = UILabel()
        winner = UILabel()
        status = UILabel()
        missles = UILabel()
        super.init(frame: frame)
        backgroundColor = .lightGray
    }
    
    override func draw(_ rect: CGRect) {
        
        gameDetailLabel.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.1, width: 200, height: 50)
        gameDetailLabel.text = "Game Details"
        gameDetailLabel.textAlignment = NSTextAlignment.center
        gameDetailLabel.font = UIFont(name: "HelveticaNeue", size: 35)
        gameDetailLabel.textColor = .white
        
        gameName.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.24, width: 200, height: 50)
        gameName.textAlignment = NSTextAlignment.center
        gameName.font = UIFont(name: "HelveticaNeue", size: 15)
        gameName.textColor = .white
        
        idLabel.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.26, width: 200, height: 50)
        idLabel.textAlignment = NSTextAlignment.center
        idLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        idLabel.textColor = .white
        
        player1.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.28, width: 200, height: 50)
        player1.textAlignment = NSTextAlignment.center
        player1.font = UIFont(name: "HelveticaNeue", size: 15)
        player1.textColor = .white
        
        player2.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.30, width: 200, height: 50)
        player2.textAlignment = NSTextAlignment.center
        player2.font = UIFont(name: "HelveticaNeue", size: 15)
        player2.textColor = .white
        
        winner.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.32, width: 200, height: 50)
        winner.textAlignment = NSTextAlignment.center
        winner.font = UIFont(name: "HelveticaNeue", size: 15)
        winner.textColor = .white
        
        status.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.34, width: 200, height: 50)
        status.textAlignment = NSTextAlignment.center
        status.font = UIFont(name: "HelveticaNeue", size: 15)
        status.textColor = .white
        
        missles.frame = CGRect(x: (frame.width / 2.0) - (200.0 / 2.0), y: frame.height * 0.36, width: 200, height: 50)
        missles.textAlignment = NSTextAlignment.center
        missles.font = UIFont(name: "HelveticaNeue", size: 15)
        missles.textColor = .white
        
        addSubview(idLabel)
        addSubview(gameDetailLabel)
        addSubview(player1)
        addSubview(player2)
        addSubview(winner)
        addSubview(status)
        addSubview(missles)
    }
    
    func reloadData() {
        setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

