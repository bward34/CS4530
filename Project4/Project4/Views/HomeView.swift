//
//  HomeView.swift
//  Project3 - Project4
//
//  Created by Brandon Ward on 3/3/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

protocol HomeViewDelegate {
    func homeView(_ homeView: HomeView, cellIndex: Int)
    func homeView(_ homeView: HomeView, refreshTable cellIndex: Int)
    func homeView(_ homeView: HomeView)
}
class HomeView: UIView {
    
    var gameLabel : UILabel
    var swipeLabel : UILabel
    var emptyLabel : UILabel
    var gameFilter : UISegmentedControl
    var homeTableView: UITableView
    var newGameButton: UIButton
    var gameRefresh : UIRefreshControl
    
    var delegate: HomeViewDelegate!
    
    func reloadData() {
        setNeedsDisplay()
    }

    override init(frame: CGRect) {
        homeTableView = UITableView()
        newGameButton = UIButton()
        gameLabel = UILabel()
        swipeLabel = UILabel()
        emptyLabel = UILabel()
        gameRefresh = UIRefreshControl()
        gameFilter = UISegmentedControl()
        homeTableView.refreshControl = gameRefresh
        gameRefresh.attributedTitle = NSAttributedString(string: "Getting games...")
        gameFilter.insertSegment(withTitle: "Waiting", at: 0, animated: true)
        gameFilter.insertSegment(withTitle: "Playing", at: 1, animated: true)
        gameFilter.insertSegment(withTitle: "Done", at: 2, animated: true)
        gameFilter.insertSegment(withTitle: "My Games", at: 3, animated: true)
        
        super.init(frame: frame)
        
        emptyLabel = UILabel(frame:  CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: bounds.size.width, height: bounds.size.height)))
        emptyLabel.text = "LOADING GAMES..."
        emptyLabel.numberOfLines = 0;
        emptyLabel.textAlignment = .center;
        emptyLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 20)
        emptyLabel.sizeToFit()
        
        newGameButton.addTarget(self, action: #selector(newGame), for: UIControl.Event.touchUpInside)
        gameFilter.addTarget(self, action: #selector(filterGames), for: UIControl.Event.valueChanged)
        gameRefresh.addTarget(self, action: #selector(refreshTable), for: UIControl.Event.valueChanged)
        homeTableView.register(HomeViewTableCell.self, forCellReuseIdentifier: String(describing: HomeViewTableCell.self))
        homeTableView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.darkGray
    }
    
    override func draw(_ rect: CGRect) {
        gameLabel.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        gameLabel.text = "BATTLESHIP"
        gameLabel.textAlignment = NSTextAlignment.center
        gameLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 35)
        gameLabel.textColor = .white
        gameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        gameFilter.frame = CGRect(x: 100, y: 200, width: 100, height: 50)
        gameFilter.tintColor = .white
        gameFilter.backgroundColor = .red
        gameFilter.layer.cornerRadius = 5
        gameFilter.translatesAutoresizingMaskIntoConstraints = false
        
        swipeLabel.frame = CGRect(x: 100, y: 100, width: 100, height: 10)
        swipeLabel.text = "SWIPE DOWN TO REFRESH"
        swipeLabel.textAlignment = NSTextAlignment.center
        swipeLabel.font = UIFont(name: "AvenirNext-UltraLight", size: 11)
        swipeLabel.textColor = .white
        swipeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        newGameButton.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        newGameButton.setTitle("NEW GAME", for: .normal)
        newGameButton.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 20)
        newGameButton.backgroundColor = UIColor.red
        newGameButton.layer.cornerRadius = 5
        newGameButton.layer.borderWidth = 1
        newGameButton.layer.borderColor = UIColor.white.cgColor
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        
        homeTableView.layer.cornerRadius = 5
        
        addSubview(gameLabel)
        addSubview(gameFilter)
        addSubview(swipeLabel)
        addSubview(newGameButton)
        addSubview(homeTableView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[gameLabel]-|", options: [], metrics: nil, views: ["gameLabel": gameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[gameFilter]-|", options: [], metrics: nil, views: ["gameFilter": gameFilter]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[swipeLabel]-|", options: [], metrics: nil, views: ["swipeLabel": swipeLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[homeTableView]-|", options: [], metrics: nil, views: ["homeTableView": homeTableView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[newGameButton]-|", options: [], metrics: nil, views: ["newGameButton": newGameButton]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[gameLabel]-[gameFilter]-[swipeLabel]-[homeTableView]-[newGameButton]-12-|", options: [], metrics: nil, views: ["gameLabel" : gameLabel, "swipeLabel": swipeLabel, "gameFilter" : gameFilter,"homeTableView": homeTableView, "newGameButton" : newGameButton]))
    }
    
    
    @objc func newGame() {
        delegate.homeView(self)
    }
    
    @objc func refreshTable() {
        delegate.homeView(self, refreshTable: gameFilter.selectedSegmentIndex)
    }
    
    @objc func filterGames() {
        delegate.homeView(self, cellIndex: gameFilter.selectedSegmentIndex)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
