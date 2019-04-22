//
//  GameOverView.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/20/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

protocol GameOverViewDelegate {
    func goHome(_ gameOverView : GameOverView)
}

class GameOverView : UIView {
    
    var delegate : GameOverViewDelegate?
    
    var gameOverLabel : UILabel
    var goHomeButton : UIButton
    
    var stackView : UIStackView
    
    override init(frame: CGRect) {
        gameOverLabel = UILabel()
        goHomeButton = UIButton()
        stackView = UIStackView()
        super.init(frame: frame)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "galaxy.jpeg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        insertSubview(backgroundImage, at: 0)
        
        goHomeButton.addTarget(self, action: #selector(goHome), for: UIControl.Event.touchUpInside)
    }
    
    override func draw(_ rect: CGRect) {
        gameOverLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gameOverLabel)
        gameOverLabel.text = "Game Over!"
        gameOverLabel.font = UIFont(name: "Future-Earth", size: 40)
        gameOverLabel.textAlignment = NSTextAlignment.center
        gameOverLabel.textColor = .white
        
        goHomeButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(goHomeButton)
        goHomeButton.setTitle("Home", for: .normal)
        goHomeButton.titleLabel?.font = UIFont(name: "Future-Earth", size: 12)
        goHomeButton.backgroundColor = .red
        goHomeButton.layer.cornerRadius = 5
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12.0).isActive = true
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 30.0
        
        stackView.addArrangedSubview(gameOverLabel)
        stackView.addArrangedSubview(goHomeButton)
        
        let view : [String : Any] = ["titleLabel" : gameOverLabel,
                                     "newGameButton" : goHomeButton]
        
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(<=\(frame.width * 0.25))-[newGameButton]-(<=\(frame.width * 0.25))-|", options: [], metrics: nil, views: view))
        
    }
    
    @objc func goHome() {
        delegate?.goHome(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
