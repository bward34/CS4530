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
        asteriods.startTimer()
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
        let documentsDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        do {
            try asteriods.save(to: documentsDirectory.appendingPathComponent(Constants.gamesList))
        } catch let error where error is Asteriods.Error {
            print(error)
        } catch {
            print(error)
        }
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
        return ((x: CGFloat(asteriods.ship.currPosX), y: CGFloat(asteriods.ship.currPosY)), CGFloat(asteriods.ship.currAngle))
    }
    
    func getAsteroidInfo(_ gameView: GameView) -> [Int : [(x: CGFloat, y: CGFloat)]] {
        return asteriods.asteroidInfo()
    }
    
    func getLaserInfo(_ gameView: GameView) -> [((x: CGFloat, y: CGFloat), CGFloat)] {
        return asteriods.laserInfo()
    }
    
    func getNumLives(_ gameView: GameView) -> Int {
        return asteriods.lives
    }
    
    func getScore(_ gaveView: GameView) -> Int {
        return asteriods.score
    }
    
    func updateFrame(_ gameView: GameView, newPoint: CGPoint) {
        asteriods.ship.currPosX = Float(newPoint.x)
        asteriods.ship.currPosY = Float(newPoint.y)
    }
    
    func rotatePushed(_ gameView: GameView, sender: Any) {
        if let button = sender as? UIButton {
            if button == gameView.rotateLeftButton {
                asteriods.updateLeftRotate(rotate: true)
            }
            else if button == gameView.rotateRightButton {
                asteriods.updateRightRotate(rotate: true)
            }
        }
    }
    
    func rotatePushedEnd(_ gameView: GameView, sender: Any) {
        if let button = sender as? UIButton {
            if button == gameView.rotateLeftButton {
                asteriods.updateLeftRotate(rotate: false)
            }
            else if button == gameView.rotateRightButton {
                asteriods.updateRightRotate(rotate: false)
            }
        }
    }
    
    @objc func updateGameView() {
        gameView.updateDisplay()
        if asteriods.lives == 0 {
            gameViewTimer.invalidate()
            let gameOverController : GameOverViewController = GameOverViewController()
            present(gameOverController, animated: true, completion: nil)
        }
        //gameView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
