//
//  HomeView.swift
//  Project3 - Project4
//
//  Created by Brandon Ward on 3/3/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

protocol HomeViewDelegate {
    func homeView(_ homeView: HomeView)
}
class HomeView: UIView {
    
    var gameLabel : UILabel
    var homeTableView: UITableView
    var newGameButton: UIButton
    
    var delegate: HomeViewDelegate!
    
    func reloadData() {
        setNeedsDisplay()
    }

    override init(frame: CGRect) {
        homeTableView = UITableView()
        newGameButton = UIButton()
        gameLabel = UILabel()
        super.init(frame: frame)
        homeTableView.register(HomeViewTableCell.self, forCellReuseIdentifier: String(describing: HomeViewTableCell.self))
        homeTableView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.darkGray
    }
    
    override func draw(_ rect: CGRect) {
        gameLabel.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        gameLabel.text = "BATTLESHIP"
        gameLabel.textAlignment = NSTextAlignment.center
        gameLabel.font = UIFont(name: "HelveticaNeue", size: 35)
        gameLabel.textColor = .white
        gameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        newGameButton.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        newGameButton.setTitle("NEW GAME", for: .normal)
        newGameButton.backgroundColor = UIColor.red
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(gameLabel)
        addSubview(newGameButton)
        addSubview(homeTableView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[gameLabel]-|", options: [], metrics: nil, views: ["gameLabel": gameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[homeTableView]-|", options: [], metrics: nil, views: ["homeTableView": homeTableView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[newGameButton]-|", options: [], metrics: nil, views: ["newGameButton": newGameButton]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[gameLabel]-[homeTableView]-[newGameButton]-12-|", options: [], metrics: nil, views: ["gameLabel" : gameLabel,"homeTableView": homeTableView, "newGameButton" : newGameButton]))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
