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
    var stackView : UIStackView
    
    override init(frame: CGRect) {
        gameDetailLabel = UILabel()
        stackView = UIStackView()
        gameName = UILabel()
        idLabel = UILabel()
        player1 = UILabel()
        player2 = UILabel()
        winner = UILabel()
        status = UILabel()
        missles = UILabel()
        super.init(frame: frame)
        backgroundColor = .blue
    }
    
    override func draw(_ rect: CGRect) {
        
        gameDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gameDetailLabel)
        gameDetailLabel.text = "Game Details"
        gameDetailLabel.textAlignment = NSTextAlignment.center
        gameDetailLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 35)
        gameDetailLabel.textColor = .white
        
        gameName.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gameName)
        gameName.textAlignment = NSTextAlignment.center
        gameName.font = UIFont(name: "Futura-CondensedExtraBold", size: 15)
        gameName.textColor = .white
        
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(idLabel)
        idLabel.textAlignment = NSTextAlignment.center
        idLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 12)
        idLabel.textColor = .white
        
        player1.translatesAutoresizingMaskIntoConstraints = false
        addSubview(player1)
        player1.textAlignment = NSTextAlignment.center
        player1.font = UIFont(name: "Futura-CondensedExtraBold", size: 15)
        player1.textColor = .white
        
        player2.translatesAutoresizingMaskIntoConstraints = false
        addSubview(player2)
        player2.textAlignment = NSTextAlignment.center
        player2.font = UIFont(name: "Futura-CondensedExtraBold", size: 15)
        player2.textColor = .white
        
        winner.translatesAutoresizingMaskIntoConstraints = false
        addSubview(winner)
        winner.textAlignment = NSTextAlignment.center
        winner.font = UIFont(name: "Futura-CondensedExtraBold", size: 15)
        winner.textColor = .white
        
        status.translatesAutoresizingMaskIntoConstraints = false
        addSubview(status)
        status.textAlignment = NSTextAlignment.center
        status.font = UIFont(name: "Futura-CondensedExtraBold", size: 15)
        status.textColor = .white
        
        missles.translatesAutoresizingMaskIntoConstraints = false
        addSubview(missles)
        missles.textAlignment = NSTextAlignment.center
        missles.font = UIFont(name: "Futura-CondensedExtraBold", size: 15)
        missles.textColor = .white
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12.0).isActive = true
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 5.0
        
        stackView.addArrangedSubview(gameDetailLabel)
        stackView.addArrangedSubview(gameName)
        stackView.addArrangedSubview(idLabel)
        stackView.addArrangedSubview(player1)
        stackView.addArrangedSubview(player2)
        stackView.addArrangedSubview(winner)
        stackView.addArrangedSubview(status)
        stackView.addArrangedSubview(missles)
        
        let view: [String : Any] = ["gameDetailLabel" : gameDetailLabel, "gameName" : gameName,
                                    "idLabel": idLabel, "player1" : player1,
                                    "player2" : player2, "winner" : winner,
                                    "status" : status, "missiles" : missles]
        
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[gameDetailLabel]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[gameName]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[idLabel]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[player1]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[player2]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[winner]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[status]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[missiles]-|", options: [], metrics: nil, views: view))
        
    }
    
    func reloadData() {
        setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

