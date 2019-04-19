//
//  GameViewController.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/4/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class GameViewController : UIViewController, GameViewDelegate {

    var asteriods : Asteriods
    
    var gameViewTimer : Timer
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        asteriods = Asteriods()
        gameViewTimer = Timer()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        gameViewTimer = Timer.scheduledTimer(timeInterval: 1 / 60, target: self, selector: #selector(updateGameView), userInfo: nil, repeats: true)
    }
    
    var gameView : GameView {
        return view as! GameView
    }
    
    override func loadView() {
        view = GameView()
    }
    
    override func viewDidLoad() {
        gameView.reloadData()
        gameView.delegate = self
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        asteriods.updateFrame(newFrame: gameView.frame)
        gameView.reloadData()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func homePushed(_ gameView: GameView) {
        dismiss(animated: true, completion: nil)
    }
    
    func accleratePushed(_ gameView: GameView) {
      asteriods.updateThruster(thrusterOn: true)
    }
    
    func acclerateRealeased(_ gameView: GameView) {
      asteriods.updateThruster(thrusterOn: false)
    }
    
    func firePushed(_ gameView: GameView) {
      asteriods.updateLaser(laserOn: true)
    }
    
    func fireReleased(_ gameView: GameView) {
      asteriods.updateLaser(laserOn: false)
    }
    
    func getFrame(_ gameView: GameView) -> ((x: CGFloat, y: CGFloat), CGFloat) {
         return (asteriods.ship.currPos, asteriods.ship.currAngle)
    }
    
    func getAsteroidInfo(_ gameView: GameView) -> [Int : [(x: CGFloat, y: CGFloat)]] {
        return asteriods.asteroidInfo()
    }
    
    func getLaserInfo(_ gameView: GameView) -> [((x: CGFloat, y: CGFloat), CGFloat)] {
        return asteriods.laserInfo()
    }
    
    func updateFrame(_ gameView: GameView, newPoint: CGPoint) {
        asteriods.ship.currPos.x = newPoint.x
        asteriods.ship.currPos.y = newPoint.y
    }
    
    func rotatePushed(_ gameView: GameView, sender: Any) {
        if let button = sender as? UIButton {
            if button == gameView.rotateLeftButton {
//                    gameView.currAngle -= (2.0 * .pi) / 180.0
//                    self.asteriods.ship.currAngle = gameView.currAngle
                asteriods.updateLeftRotate(rotate: true)
            }
            else if button == gameView.rotateRightButton {
//                    gameView.currAngle += (2.0 * .pi) / 180.0
//                    self.asteriods.ship.currAngle = gameView.currAngle
                asteriods.updateRightRotate(rotate: true)
            }
        }
    }
    
    func rotatePushedEnd(_ gameView: GameView, sender: Any) {
        if let button = sender as? UIButton {
            if button == gameView.rotateLeftButton {
                //                    gameView.currAngle -= (2.0 * .pi) / 180.0
                //                    self.asteriods.ship.currAngle = gameView.currAngle
                asteriods.updateLeftRotate(rotate: false)
            }
            else if button == gameView.rotateRightButton {
                //                    gameView.currAngle += (2.0 * .pi) / 180.0
                //                    self.asteriods.ship.currAngle = gameView.currAngle
                asteriods.updateRightRotate(rotate: false)
            }
        }
    }
    
    @objc func updateGameView() {
        gameView.updateDisplay()
        gameView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
