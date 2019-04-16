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
    
    func accleratePushed(_ gameView: GameView) {
      asteriods.updateThruster(thrusterOn: true)
    }
    
    func acclerateRealeased(_ gameView: GameView) {
      asteriods.updateThruster(thrusterOn: false)
    }
    
    func getFrame(_ gameView: GameView) -> (x: CGFloat, y: CGFloat) {
         return asteriods.ship.currPos
    }
    
    func rotatePushed(_ gameView: GameView, sender: Any) {
        if let button = sender as? UIButton {
            if button == gameView.rotateLeftButton {
                    gameView.currAngle -= (2.0 * .pi) / 180.0
                    self.asteriods.ship.currAngle = gameView.currAngle
            }
            else if button == gameView.rotateRightButton {
                    gameView.currAngle += (2.0 * .pi) / 180.0
                    self.asteriods.ship.currAngle = gameView.currAngle
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
