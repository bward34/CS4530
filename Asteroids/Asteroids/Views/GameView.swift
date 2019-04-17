//
//  GameView.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/4/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

protocol GameViewDelegate {
    func homePushed(_ gameView : GameView)
    func accleratePushed(_ gameView : GameView)
    func acclerateRealeased(_ gameView : GameView)
    func rotatePushed(_ gameView : GameView, sender : Any)
    func getFrame(_ gameView : GameView) -> (x: CGFloat, y: CGFloat)
    func updateFrame(_ gameView: GameView, newPoint : CGPoint)
}

class GameView : UIView {
    
    var rotateLeftButton : UIButton
    var rotateRightButton : UIButton
    var accelerateButton : UIButton
    var homeButton : UIButton
    
    var scoreLabel : UILabel
    var livesLabel : UILabel
    
    var delegate : GameViewDelegate?
    
    var ship: ShipView
    var largeAsteroid: LargeAsteroidView
    var mediumAsteroid : MediumAsteroidView
    var smallAsteroid : SmallAsteroidView
    var currAngle : CGFloat
    
    override init(frame: CGRect) {
        
        rotateLeftButton = UIButton()
        rotateRightButton = UIButton()
        accelerateButton = UIButton()
        homeButton = UIButton()
        scoreLabel = UILabel()
        livesLabel = UILabel()
        ship = ShipView()
        largeAsteroid = LargeAsteroidView()
        mediumAsteroid = MediumAsteroidView()
        smallAsteroid = SmallAsteroidView()
        currAngle = 0
        super.init(frame : frame)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "stars.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        insertSubview(backgroundImage, at: 0)
        
        accelerateButton.addTarget(self, action: #selector(accelerate), for: UIControl.Event.touchDown)
        accelerateButton.addTarget(self, action: #selector(acclerateEnd), for: UIControl.Event.touchUpInside)
        rotateLeftButton.addTarget(self, action: #selector(rotateShip), for: UIControl.Event.allEvents)
        rotateRightButton.addTarget(self, action: #selector(rotateShip), for: UIControl.Event.allEvents)
        homeButton.addTarget(self, action: #selector(goHome), for: UIControl.Event.touchUpInside)
        
        addSubview(largeAsteroid)
        addSubview(mediumAsteroid)
        addSubview(smallAsteroid)
        
        ship.contentMode = .redraw
        addSubview(ship)
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "0000"
        scoreLabel.font = UIFont(name: "Future-Earth", size: 12)
        scoreLabel.textColor = .white
        addSubview(scoreLabel)
        
        livesLabel.translatesAutoresizingMaskIntoConstraints = false
        livesLabel.text = "▲▲▲"
        livesLabel.font = UIFont(name: "Future-Earth", size: 18)
        livesLabel.textColor = .white
        addSubview(livesLabel)
        
        accelerateButton.translatesAutoresizingMaskIntoConstraints = false
        accelerateButton.setTitle("Acclerate", for: .normal)
        accelerateButton.titleLabel?.font = UIFont(name: "Future-Earth", size: 12)
        addSubview(accelerateButton)
        
        rotateLeftButton.translatesAutoresizingMaskIntoConstraints = false
        rotateLeftButton.setTitle("LEFT", for: .normal)
        rotateLeftButton.titleLabel?.font = UIFont(name: "Future-Earth", size: 12)
        addSubview(rotateLeftButton)
        
        rotateRightButton.translatesAutoresizingMaskIntoConstraints = false
        rotateRightButton.setTitle("RIGHT", for: .normal)
        rotateRightButton.titleLabel?.font = UIFont(name: "Future-Earth", size: 12)
        addSubview(rotateRightButton)
        
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        homeButton.setTitle("HOME", for: .normal)
        homeButton.titleLabel?.font = UIFont(name: "Future-Earth", size: 12)
        addSubview(homeButton)
        
        homeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        homeButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scoreLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        scoreLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        
        livesLabel.topAnchor.constraint(equalTo: scoreLabel.topAnchor, constant: 15).isActive = true
        livesLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        
        rotateLeftButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        rotateLeftButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        
        rotateRightButton.bottomAnchor.constraint(equalTo: rotateLeftButton.bottomAnchor).isActive = true
        rotateRightButton.leftAnchor.constraint(equalTo: rotateLeftButton.leftAnchor, constant: 70).isActive = true
        
        accelerateButton.bottomAnchor.constraint(equalTo: rotateLeftButton.bottomAnchor).isActive = true
        accelerateButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
    }
    
    override func draw(_ rect: CGRect) {
        largeAsteroid.frame =  CGRect(x: frame.midX * 0.24, y: frame.midY * 0.23, width: 120.0, height: 120.0)
        mediumAsteroid.frame =  CGRect(x: frame.midX * 0.24, y: frame.midY * 0.8, width: 80.0, height: 80.0)
        smallAsteroid.frame =  CGRect(x: frame.midX * 0.24, y: frame.midY * 1.25, width: 40.0, height: 40.0)
    }
    
    
    func reloadData() {
       setNeedsDisplay()
    }
    
    func updateDisplay() {
        if let frame : (x: CGFloat, y: CGFloat) = delegate?.getFrame(self) {
            ship.center = CGPoint(x: frame.x, y: frame.y)
            ship.bounds = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
            ship.transform = CGAffineTransform(rotationAngle: (currAngle - (2.0 * .pi) / 180.0))
        }
    }
    
    @objc func goHome() {
        delegate?.homePushed(self)
    }
    
    @objc func accelerate() {
        delegate?.accleratePushed(self)
    }
    
    @objc func acclerateEnd() {
        delegate?.acclerateRealeased(self)
    }
    
    @objc func rotateShip(sender : Any) {
        delegate?.rotatePushed(self, sender: sender)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
