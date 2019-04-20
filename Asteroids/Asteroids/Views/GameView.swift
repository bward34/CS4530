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
    func getAsteroidInfo(_ gameView : GameView) -> [Int : [(x: CGFloat, y: CGFloat)]]
    func getLaserInfo(_ gameView : GameView) -> [((x: CGFloat, y: CGFloat), CGFloat)]
    func updateFrame(_ gameView: GameView, newPoint : CGPoint)
    func getNumLives(_ gameView: GameView) -> Int
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
    var asteroidViews : [ Int : [Any]]
    var laserViews : [LaserView]
    
    override init(frame: CGRect) {
        let large : [LargeAsteroidView] = []
        let medium : [MediumAsteroidView] = []
        let small : [SmallAsteroidView] = []
        asteroidViews = [1 : large, 2 : medium, 3 : small]
        laserViews = []
        rotateLeftButton = UIButton()
        rotateRightButton = UIButton()
        accelerateButton = UIButton()
        laserButton = UIButton()
        homeButton = UIButton()
        scoreLabel = UILabel()
        livesLabel = UILabel()
        ship = ShipView()
        super.init(frame : frame)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "stars.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        insertSubview(backgroundImage, at: 0)
        
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
        addSubview(ship)
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "0000"
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
    }
    
    override func draw(_ rect: CGRect) {
    }
    
    
    func reloadData() {
       setNeedsDisplay()
    }
    
    func updateDisplay() {
        if let numLives : Int = delegate?.getNumLives(self) {
            var liveIcon : String = ""
//            for _ in 0 ..< numLives {
//                liveIcon += "▲"
//            }
             livesLabel.text = liveIcon
        }
        if let frame : ((x: CGFloat, y: CGFloat), CGFloat) = delegate?.getFrame(self) {
            ship.center = CGPoint(x: frame.0.x, y: frame.0.y)
            ship.bounds = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
            ship.transform = CGAffineTransform(rotationAngle: (frame.1 - (2.0 * .pi) / 180.0))
        }
        for item in laserViews {
            item.removeFromSuperview()
        }
        if let laserArray : [((x: CGFloat, y: CGFloat), CGFloat)] = delegate?.getLaserInfo(self) {
            for laser in laserArray {
                let newLaser : LaserView = LaserView()
                newLaser.center.x = laser.0.x
                newLaser.center.y = laser.0.y
                newLaser.transform  = CGAffineTransform(rotationAngle: (laser.1 - (2.0 * .pi) / 180.0))
                newLaser.bounds = CGRect.init(x: 0.0, y: 0.0, width: 3.0, height: 10.0)
                addSubview(newLaser)
                laserViews.append(newLaser)
            }
        }
        if let dict : [Int : [(x: CGFloat, y: CGFloat)]] = delegate?.getAsteroidInfo(self) {
            for (key, list) in dict {
                    if key == 1 {
                        for i in 0 ..< list.count {
                            if asteroidViews[key]!.count > 0 && list.count < asteroidViews[key]!.count {
                                (asteroidViews[key]?[i] as AnyObject).removeFromSuperview()
                                asteroidViews[key]?.remove(at: i)
                                
                            }
                            else if list.count != asteroidViews[key]?.count {
                                let largeAsteroid = LargeAsteroidView()
                                largeAsteroid.center = CGPoint(x: list[i].x, y: list[i].y)
                                largeAsteroid.bounds = CGRect.init(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
                                addSubview(largeAsteroid)
                                asteroidViews[key]?.append(largeAsteroid)
                            }
                            else {
                                let updateLarge : LargeAsteroidView = asteroidViews[key]?[i] as! LargeAsteroidView
                                updateLarge.center = CGPoint(x: list[i].x, y: list[i].y)
                                updateLarge.bounds = CGRect.init(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
                                asteroidViews[key]?[i] = updateLarge
                            }
                        }
                    }
                    if key == 2 {
                        for i in 0 ..< list.count {
                            if asteroidViews[key]!.count > 0 && list.count < asteroidViews[key]!.count {
                                (asteroidViews[key]?[i] as AnyObject).removeFromSuperview()
                                asteroidViews[key]?.remove(at: i)
                            }
                            else if list.count != asteroidViews[key]?.count {
                                let mediumAsteroid = MediumAsteroidView()
                                mediumAsteroid.center = CGPoint(x: list[i].x, y: list[i].y)
                                mediumAsteroid.bounds = CGRect.init(x: 0.0, y: 0.0, width: 60.0, height: 60.0)
                                addSubview(mediumAsteroid)
                                asteroidViews[key]?.append(mediumAsteroid)
                            }
                            else {
                                let updateMedium : MediumAsteroidView = asteroidViews[key]?[i] as! MediumAsteroidView
                                updateMedium.center = CGPoint(x: list[i].x, y: list[i].y)
                                updateMedium.bounds = CGRect.init(x: 0.0, y: 0.0, width: 60.0, height: 60.0)
                                asteroidViews[key]?[i] = updateMedium
                            }
                        }
                    }
                    if key == 3 {
                        for i in 0 ..< list.count {
                            if asteroidViews[key]!.count > 0 && list.count < asteroidViews[key]!.count {
                                (asteroidViews[key]?[i] as AnyObject).removeFromSuperview()
                                asteroidViews[key]?.remove(at: i)
                            }
                            else if list.count != asteroidViews[key]?.count {
                                let smallAsteroid = SmallAsteroidView()
                                smallAsteroid.center = CGPoint(x: list[i].x, y: list[i].y)
                                smallAsteroid.bounds = CGRect.init(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
                                addSubview(smallAsteroid)
                                asteroidViews[key]?.append(smallAsteroid)
                            }
                            else {
                                let updateSmall : SmallAsteroidView = asteroidViews[key]?[i] as! SmallAsteroidView
                                updateSmall.center = CGPoint(x: list[i].x, y: list[i].y)
                                updateSmall.bounds = CGRect.init(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
                                asteroidViews[key]?[i] = updateSmall
                            }
                        }
                    }
            }
        }
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
    }
    
    @objc func acclerateEnd() {
        delegate?.acclerateRealeased(self)
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
