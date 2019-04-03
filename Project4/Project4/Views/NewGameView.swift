//
//  NewGameView.swift
//  Project3 - Project4
//
//  Created by Brandon Ward on 3/22/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

protocol NewGameViewDelegate {
  func newGameView(_ newGameView: NewGameView)
  func newGameView(createGame newGameView: NewGameView)
    
}
class NewGameView: UIView {
    
    var newGameLabel : UILabel
    var gameNameLabel: UILabel
    var gameNameField: UITextField
    var playerNameLabel: UILabel
    var playerNameField: UITextField
    var backLabel : UIButton
    var createGame : UIButton
    var stackView : UIStackView
    var delegate : NewGameViewDelegate?
    
    override init(frame: CGRect) {
        stackView = UIStackView()
        playerNameLabel = UILabel()
        gameNameLabel = UILabel()
        gameNameField = UITextField()
        newGameLabel = UILabel()
        playerNameField = UITextField()
        backLabel = UIButton()
        createGame = UIButton()
        super.init(frame: frame)
        backgroundColor = .darkGray
        backLabel.addTarget(self, action: #selector(goHome), for: UIControl.Event.touchUpInside)
        createGame.addTarget(self, action: #selector(createNewGame), for: UIControl.Event.touchUpInside)
    }
    
    override func draw(_ rect: CGRect) {
        
        backLabel.setTitle("←HOME", for: .normal)
        backLabel.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 20)
        backLabel.backgroundColor = .blue
        backLabel.layer.cornerRadius = 5
        backLabel.layer.borderColor = UIColor.white.cgColor
        backLabel.layer.borderWidth = 1
        backLabel.frame = CGRect(x: frame.origin.x + 5.0, y: frame.origin.y + 20.0, width: 75.0, height: 25.0)
        addSubview(backLabel)

        newGameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(newGameLabel)
        newGameLabel.text = "New Game"
        newGameLabel.textAlignment = NSTextAlignment.center
        newGameLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 35)
        newGameLabel.textColor = .white
    
        gameNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gameNameLabel)
        gameNameLabel.text = "Enter a game name:"
        gameNameLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 15)
        gameNameLabel.textColor = .white
        
        gameNameField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gameNameField)
        gameNameField.backgroundColor = UIColor.white
        gameNameField.layer.cornerRadius = 5
        gameNameField.returnKeyType = .done
        gameNameField.addTarget(self, action: #selector(closeKeyBoard), for: .editingDidEndOnExit)
        
        playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playerNameLabel)
        playerNameLabel.text = "Enter your name:"
        playerNameLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 15)
        playerNameLabel.textColor = .white
        
        playerNameField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playerNameField)
        playerNameField.backgroundColor = UIColor.white
        playerNameField.layer.cornerRadius = 5
        playerNameField.returnKeyType = .done
        playerNameField.addTarget(self, action: #selector(closeKeyBoard), for: .editingDidEndOnExit)
        
        createGame.translatesAutoresizingMaskIntoConstraints = false
        addSubview(createGame)
        createGame.setTitle("Create Game", for: .normal)
        createGame.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 20)
        createGame.backgroundColor = .green
        createGame.layer.cornerRadius = 5
        createGame.layer.borderColor = UIColor.white.cgColor
        createGame.layer.borderWidth = 1
    
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
 
        stackView.addArrangedSubview(newGameLabel)
        stackView.addArrangedSubview(gameNameLabel)
        stackView.addArrangedSubview(gameNameField)
        stackView.addArrangedSubview(playerNameLabel)
        stackView.addArrangedSubview(playerNameField)
        stackView.addArrangedSubview(createGame)
        
        let view: [String : Any] = ["newGameLabel" : newGameLabel, "gameNameLabel" : gameNameLabel,
                                   "gameNameField": gameNameField, "playerNameField" : playerNameField,
                                   "playerNameLabel" : playerNameLabel, "createGame" : createGame]
        
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[newGameLabel]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[gameNameLabel]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[gameNameField]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[playerNameLabel]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[playerNameField]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(<=\(frame.width * 0.25))-[createGame]-(<=\(frame.width * 0.25))-|", options: [], metrics: nil, views: view))
    }
    
    @objc func closeKeyBoard(sender: Any) {
        if let textField = sender as? UITextField {
            textField.resignFirstResponder()
        }
    }
    
    @objc func goHome() {
        delegate?.newGameView(self)
    }
    
    @objc func createNewGame() {
        delegate?.newGameView(createGame: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
