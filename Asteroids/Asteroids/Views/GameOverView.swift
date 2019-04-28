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
    func checkScore(_ gameOverView : GameOverView) -> Bool
}

class GameOverView : UIView {
    
    var delegate : GameOverViewDelegate?
    
    var gameOverLabel : UILabel
    var gameScore : UILabel
    var goHomeButton : UIButton
    var playerNameField: UITextField
    
    var stackView : UIStackView
    
    override init(frame: CGRect) {
        playerNameField = UITextField()
        gameOverLabel = UILabel()
        gameScore = UILabel()
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
        
        gameScore.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gameScore)
        gameScore.font = UIFont(name: "Future-Earth", size: 20)
        gameScore.textAlignment = NSTextAlignment.center
        gameScore.textColor = .white
        
        playerNameField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playerNameField)
        playerNameField.backgroundColor = UIColor.black
        playerNameField.font = UIFont(name: "Future-Earth", size: 16)
        playerNameField.textColor = UIColor(hue: 0.3194, saturation: 1, brightness: 1, alpha: 1.0)
        playerNameField.layer.cornerRadius = 5
        playerNameField.layer.borderWidth = 2
        playerNameField.layer.borderColor = UIColor(hue: 0.3194, saturation: 1, brightness: 1, alpha: 1.0).cgColor
        playerNameField.returnKeyType = .done
        playerNameField.attributedPlaceholder = NSAttributedString(string:"Enter name for High Score", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hue: 0.3194, saturation: 1, brightness: 1, alpha: 1.0)])
        playerNameField.addTarget(self, action: #selector(closeKeyBoard), for: .editingDidEndOnExit)
        
        goHomeButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(goHomeButton)
        goHomeButton.setTitle("Home", for: .normal)
        goHomeButton.titleLabel?.font = UIFont(name: "Future-Earth", size: 12)
        goHomeButton.backgroundColor = .red
        goHomeButton.layer.cornerRadius = 5
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12.0).isActive = true
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 15.0
        
        stackView.addArrangedSubview(gameOverLabel)
        stackView.addArrangedSubview(gameScore)
        stackView.addArrangedSubview(playerNameField)
        stackView.addArrangedSubview(goHomeButton)
        
        let view : [String : Any] = ["titleLabel" : gameOverLabel,
                                     "gameScore" : gameScore,
                                     "playerNameField" : playerNameField,
                                     "newGameButton" : goHomeButton]
        
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[gameScore]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(<=\(frame.width * 0.25))-[playerNameField]-(<=\(frame.width * 0.25))-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(<=\(frame.width * 0.25))-[newGameButton]-(<=\(frame.width * 0.25))-|", options: [], metrics: nil, views: view))
        
        if let addScore = delegate?.checkScore(self) {
            if !addScore {
                playerNameField.isHidden = true
            }
        }
    }
    
    func reloadData() {
        setNeedsDisplay()
    }
    
    @objc func closeKeyBoard(sender: Any) {
        if let textField = sender as? UITextField {
            textField.resignFirstResponder()
        }
    }
    
    @objc func goHome() {
        delegate?.goHome(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
