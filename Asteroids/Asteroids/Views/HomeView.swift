//
//  HomeView.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/6/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

protocol HomeViewDelegate {
    func showNewGame(_ homeView : HomeView)
    func showHighScore(_ homeView : HomeView)
}

class HomeView : UIView {
    
    var delegate : HomeViewDelegate?
    
    var titleLable : UILabel
    var newGameButton : UIButton
    var highScoreButton : UIButton
    
    var stackView : UIStackView
    
    override init(frame: CGRect) {
        titleLable = UILabel()
        newGameButton = UIButton()
        highScoreButton = UIButton()
        stackView = UIStackView()
        super.init(frame: frame)
        backgroundColor = .blue
        newGameButton.addTarget(self, action: #selector(newGame), for: UIControl.Event.touchUpInside)
        highScoreButton.addTarget(self, action: #selector(loadHighScores), for: UIControl.Event.touchUpInside)
    }
    
    override func draw(_ rect: CGRect) {
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLable)
        titleLable.text = "Asteroids"
        titleLable.textAlignment = NSTextAlignment.center
        titleLable.textColor = .white
        
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(newGameButton)
        newGameButton.setTitle("New Game", for: .normal)
        newGameButton.backgroundColor = .red
        
        highScoreButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(highScoreButton)
        highScoreButton.setTitle("High Scores", for: .normal)
        highScoreButton.backgroundColor = .red
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12.0).isActive = true
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 10.0
        
        stackView.addArrangedSubview(titleLable)
        stackView.addArrangedSubview(newGameButton)
        stackView.addArrangedSubview(highScoreButton)
        
        let view : [String : Any] = ["titleLabel" : titleLable,
                                     "newGameButton" : newGameButton,
                                     "highScoreButton" : highScoreButton]
        
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(<=\(frame.width * 0.25))-[newGameButton]-(<=\(frame.width * 0.25))-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(<=\(frame.width * 0.25))-[highScoreButton]-(<=\(frame.width * 0.25))-|", options: [], metrics: nil, views: view))
        
    }
    
    @objc func newGame() {
        delegate?.showNewGame(self)
    }
    
    @objc func loadHighScores() {
        delegate?.showHighScore(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
