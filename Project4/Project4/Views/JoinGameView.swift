//
//  JoinGameView.swift
//  Project4
//
//  Created by Brandon Ward on 3/26/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

protocol JoinGameViewDelegate {
    func joinGameView(_ joinGameView: JoinGameView)
    func joinGameView(joinGame joinGameView: JoinGameView)
}

class JoinGameView: UIView {
    
    var joinGameLabel : UILabel
    var playerNameLabel: UILabel
    var playerNameField: UITextField
    var backLabel : UIButton
    var joinGame : UIButton
    var stackView : UIStackView
    var delegate : JoinGameViewDelegate?
    
    override init(frame: CGRect) {
        stackView = UIStackView()
        playerNameLabel = UILabel()
        joinGameLabel = UILabel()
        playerNameField = UITextField()
        backLabel = UIButton()
        joinGame = UIButton()
        super.init(frame: frame)
        backgroundColor = .darkGray
        backLabel.addTarget(self, action: #selector(goHome), for: UIControl.Event.touchUpInside)
        joinGame.addTarget(self, action: #selector(joinAGame), for: UIControl.Event.touchUpInside)
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
        
        joinGameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(joinGameLabel)
        joinGameLabel.text = "Join Game"
        joinGameLabel.textAlignment = NSTextAlignment.center
        joinGameLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 35)
        joinGameLabel.textColor = .white
        
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
        
        joinGame.translatesAutoresizingMaskIntoConstraints = false
        addSubview(joinGame)
        joinGame.setTitle("Join Game", for: .normal)
        joinGame.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 20)
        joinGame.backgroundColor = .green
        joinGame.layer.cornerRadius = 5
        joinGame.layer.borderColor = UIColor.white.cgColor
        joinGame.layer.borderWidth = 1
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12.0).isActive = true
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 10.0
        
        stackView.addArrangedSubview(joinGameLabel)
        stackView.addArrangedSubview(playerNameLabel)
        stackView.addArrangedSubview(playerNameField)
        stackView.addArrangedSubview(joinGame)
        
        let view: [String : Any] = ["joinGameLabel" : joinGameLabel, "playerNameLabel" : playerNameLabel,
                                    "playerNameField": playerNameField, "joinGame" : joinGame]
        
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[joinGameLabel]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[playerNameLabel]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[playerNameField]-|", options: [], metrics: nil, views: view))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(<=\(frame.width * 0.25))-[joinGame]-(<=\(frame.width * 0.25))-|", options: [], metrics: nil, views: view))
    }
    
    @objc func closeKeyBoard(sender: Any) {
        if let textField = sender as? UITextField {
            textField.resignFirstResponder()
        }
    }
    
    @objc func goHome() {
        delegate?.joinGameView(self)
    }
    
    @objc func joinAGame() {
        delegate?.joinGameView(joinGame: self)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

