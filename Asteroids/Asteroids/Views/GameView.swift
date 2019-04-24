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
    func firePushed(_ gameView : GameView)
    func fireReleased(_ gameView : GameView)
    func rotatePushed(_ gameView : GameView, sender : Any)
    func rotatePushedEnd(_ gameView : GameView, sender : Any)
    func getFrame(_ gameView : GameView) -> ((x: CGFloat, y: CGFloat), CGFloat)
    func getAsteroidInfo(_ gameView : GameView) -> [Int : [((x: CGFloat, y: CGFloat), CGFloat)]]
    func getLaserInfo(_ gameView : GameView) -> [((x: CGFloat, y: CGFloat), CGFloat)]
    func updateFrame(_ gameView: GameView, newPoint : CGPoint)
    func getNumLives(_ gameView: GameView) -> Int
    func getScore(_ gaveView: GameView) -> Int
}

class GameView : UIView {
    
    var rotateLeftButton : UIButton
    var rotateRightButton : UIButton
    var accelerateButton : UIButton
    var laserButton : UIButton
    var homeButton : UIButton
    
    var scoreLabel : UILabel
    var livesLabel : UILabel
    
    var delegate : GameViewDelegate?
    
    var ship: ShipView
    
    var largeViews : [LargeAsteroidView]
    var mediumViews : [MediumAsteroidView]
    var smallViews : [SmallAsteroidView]
    var laserViews : [LaserView]
    
    var showThruster : Bool
    
    override init(frame: CGRect) {
        largeViews = []
        mediumViews = []
        smallViews = []
        laserViews = []
        rotateLeftButton = UIButton()
        rotateRightButton = UIButton()
        accelerateButton = UIButton()
        laserButton = UIButton()
        homeButton = UIButton()
        scoreLabel = UILabel()
        livesLabel = UILabel()
        ship = ShipView()
        showThruster = false
        super.init(frame : frame)
        
        accelerateButton.addTarget(self, action: #selector(accelerate), for: UIControl.Event.touchDown)
        accelerateButton.addTarget(self, action: #selector(acclerateEnd), for: UIControl.Event.touchUpInside)
        rotateLeftButton.addTarget(self, action: #selector(rotateShip), for: UIControl.Event.touchDown)
        rotateLeftButton.addTarget(self, action: #selector(rotateShipEnd), for: UIControl.Event.touchUpInside)
        rotateRightButton.addTarget(self, action: #selector(rotateShip), for: UIControl.Event.touchDown)
        rotateRightButton.addTarget(self, action: #selector(rotateShipEnd), for: UIControl.Event.touchUpInside)
        laserButton.addTarget(self, action: #selector(fire), for: UIControl.Event.touchDown)
        laserButton.addTarget(self, action: #selector(fireEnd), for: UIControl.Event.touchUpInside)
        homeButton.addTarget(self, action: #selector(goHome), for: UIControl.Event.touchUpInside)

        ship.contentMode = .redraw
        ship.shipExhaust.isHidden = true
        addSubview(ship)
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.font = UIFont(name: "Future-Earth", size: 12)
        scoreLabel.textColor = .white
        bringSubviewToFront(scoreLabel)
        addSubview(scoreLabel)
        
        livesLabel.translatesAutoresizingMaskIntoConstraints = false
        livesLabel.font = UIFont(name: "Future-Earth", size: 18)
        livesLabel.textColor = .white
        addSubview(livesLabel)
        
        accelerateButton.translatesAutoresizingMaskIntoConstraints = false
        accelerateButton.setTitle("Acclerate", for: .normal)
        accelerateButton.titleLabel?.font = UIFont(name: "Future-Earth", size: 12)
        addSubview(accelerateButton)
        
        laserButton.translatesAutoresizingMaskIntoConstraints = false
        laserButton.setTitle("FIRE", for: .normal)
        laserButton.titleLabel?.font = UIFont(name: "Future-Earth", size: 12)
        addSubview(laserButton)
        
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
        rotateRightButton.leftAnchor.constraint(equalTo: laserButton.leftAnchor, constant: 75).isActive = true
        
        accelerateButton.bottomAnchor.constraint(equalTo: rotateLeftButton.bottomAnchor).isActive = true
        accelerateButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        laserButton.bottomAnchor.constraint(equalTo: rotateLeftButton.bottomAnchor).isActive = true
        laserButton.leftAnchor.constraint(equalTo: rotateLeftButton.leftAnchor, constant: 80).isActive = true
        
        for _ in 0 ..< 100 {
            let largeView : LargeAsteroidView = LargeAsteroidView()
            largeView.bounds = CGRect(x: 0.0, y: 0.0, width: 75.0, height: 75.0)
            addSubview(largeView)
            largeView.isHidden = true
            largeViews.append(largeView)
            
            let mediumView : MediumAsteroidView = MediumAsteroidView()
            mediumView.bounds = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
            addSubview(mediumView)
            mediumView.isHidden = true
            mediumViews.append(mediumView)
            
            let smallView : SmallAsteroidView = SmallAsteroidView()
            smallView.bounds = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
            addSubview(smallView)
            smallView.isHidden = true
            smallViews.append(smallView)
        }
        
        for _ in 0 ..< 200 {
            let laserView : LaserView = LaserView()
            laserView.bounds = CGRect.init(x: 0.0, y: 0.0, width: 3.0, height: 10.0)
            addSubview(laserView)
            laserView.isHidden = true
            laserViews.append(laserView)
        }
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "stars.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        insertSubview(backgroundImage, at: 0)
    }
    
    override func draw(_ rect: CGRect) {
    }
    
    
    func reloadData() {
       setNeedsDisplay()
    }
    
    func updateDisplay() {
        if let score : Int = delegate?.getScore(self) {
            scoreLabel.text = String(format: "%04d", score)
        }
        if let numLives : Int = delegate?.getNumLives(self) {
            var liveIcon : String = ""
            for _ in 0 ..< numLives {
                liveIcon += "▲"
            }
             livesLabel.text = liveIcon
        }
        if let frame : ((x: CGFloat, y: CGFloat), CGFloat) = delegate?.getFrame(self) {
            ship.center = CGPoint(x: frame.0.x, y: frame.0.y)
            ship.bounds = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
            ship.transform = CGAffineTransform(rotationAngle: (frame.1 - (2.0 * .pi) / 180.0))
        }
        if showThruster {
            ship.shipExhaust.isHidden = false
            let rand : Int = Int.random(in: 0...1)
            if rand == 0 {
                ship.shipExhaust.lineExhaust.isHidden = false
                ship.shipExhaust.triangleExhaust.isHidden = true
            }
            else {
                ship.shipExhaust.lineExhaust.isHidden = true
                ship.shipExhaust.triangleExhaust.isHidden = false
            }
        }
        else {
            ship.shipExhaust.isHidden = true
        }
        for item in laserViews {
            item.isHidden = true
        }
        if let laserArray : [((x: CGFloat, y: CGFloat), CGFloat)] = delegate?.getLaserInfo(self) {
            for  i in 0 ..< laserArray.count {
                laserViews[i].center.x = laserArray[i].0.x
                laserViews[i].center.y = laserArray[i].0.y
                laserViews[i].transform  = CGAffineTransform(rotationAngle: (laserArray[i].1 - (2.0 * .pi) / 180.0))
                laserViews[i].bounds = CGRect.init(x: 0.0, y: 0.0, width: 3.0, height: 10.0)
                laserViews[i].isHidden = false
            }
        }
        if let dict : [Int : [((x: CGFloat, y: CGFloat), CGFloat)]] = delegate?.getAsteroidInfo(self) {
            for (key, list) in dict {
                if key == 1 {
                        for i in 0 ..< largeViews.count {
                             if i < list.count {
                                largeViews[i].center = CGPoint(x: list[i].0.x, y: list[i].0.y)
                                largeViews[i].transform  = CGAffineTransform(rotationAngle: (list[i].1 - (2.0 * .pi) / 180.0))
                                largeViews[i].isHidden = false
                            }
                            else {
                                largeViews[i].isHidden = true
                            }
                        }
                    }
                   else if key == 2 {
                        for i in 0 ..< mediumViews.count {
                             if i < list.count{
                               mediumViews[i].center = CGPoint(x: list[i].0.x, y: list[i].0.y)
                               mediumViews[i].transform  = CGAffineTransform(rotationAngle: (list[i].1 - (2.0 * .pi) / 180.0))
                               mediumViews[i].isHidden = false
                            }
                            else {
                                mediumViews[i].isHidden = true

                            }
                        }
                    }
                    else if key == 3 {
                        for i in 0 ..< smallViews.count {
                             if i < list.count {
                                smallViews[i].center = CGPoint(x: list[i].0.x, y: list[i].0.y)
                                smallViews[i].transform  = CGAffineTransform(rotationAngle: (list[i].1 - (2.0 * .pi) / 180.0))
                                smallViews[i].isHidden = false
                            }
                            else {
                                smallViews[i].isHidden = true
                            }
                        }
                    }
            }
        }
        self.bringSubviewToFront(rotateLeftButton)
        self.bringSubviewToFront(rotateRightButton)
        self.bringSubviewToFront(laserButton)
        self.bringSubviewToFront(accelerateButton)
    }
    
    @objc func goHome() {
        delegate?.homePushed(self)
    }
    
    @objc func fire() {
        delegate?.firePushed(self)
    }
    
    @objc func fireEnd() {
        delegate?.fireReleased(self)
    }
    
    @objc func accelerate() {
        delegate?.accleratePushed(self)
        showThruster = true
    }
    
    @objc func acclerateEnd() {
        delegate?.acclerateRealeased(self)
        showThruster = false
    }
    
    @objc func rotateShip(sender : Any) {
        delegate?.rotatePushed(self, sender: sender)
    }
    
    @objc func rotateShipEnd(sender : Any) {
        delegate?.rotatePushedEnd(self, sender: sender)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
