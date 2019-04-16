//
//  HighScoreView.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/6/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

protocol HighScoreViewDelegate {
    func goBackHome(_ highScoreView : HighScoreView)
}

class HighScoreView : UIView {
    
    var highScoreLabel : UILabel
    var highScoreTableView : UITableView
    var homeButton : UIButton
    
    var delegate : HighScoreViewDelegate?
    
    override init(frame: CGRect) {
        highScoreLabel = UILabel()
        highScoreTableView = UITableView()
        homeButton = UIButton()
        super.init(frame: frame)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "stars.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        insertSubview(backgroundImage, at: 0)
        
        highScoreTableView.register(HighScoreViewTableCell.self, forCellReuseIdentifier: String(describing: HighScoreViewTableCell.self))
        highScoreTableView.translatesAutoresizingMaskIntoConstraints = false
        homeButton.addTarget(self, action: #selector(goHome), for: UIControl.Event.touchUpInside)
    }
    
    override func draw(_ rect: CGRect) {
        
        highScoreLabel.text = "High Scores"
        highScoreLabel.textAlignment = NSTextAlignment.center
        highScoreLabel.font = UIFont(name: "Future-Earth", size: 25)
        highScoreLabel.textColor = .white
        highScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        homeButton.setTitle("Home", for: .normal)
        homeButton.titleLabel?.font = UIFont(name: "Future-Earth", size: 12)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        homeButton.backgroundColor = .red
        homeButton.layer.cornerRadius = 5
        
        addSubview(highScoreLabel)
        addSubview(highScoreTableView)
        addSubview(homeButton)
        
        let view : [String : Any] = ["highScoreLabel" : highScoreLabel,
                                     "highScoreTable" : highScoreTableView,
                                     "homeButton" : homeButton]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[highScoreLabel]-|", options: [], metrics: nil, views: view))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[highScoreTable]-|", options: [], metrics: nil, views: view))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(<=\(frame.width * 0.25))-[homeButton]-(<=\(frame.width * 0.25))-|", options: [], metrics: nil, views: view))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[highScoreLabel]-[highScoreTable]-[homeButton]-12-|", options: [], metrics: nil, views: view))
    }
    
    @objc func goHome() {
        delegate?.goBackHome(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
