//
//  GameViewController.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/4/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class GameViewController : UIViewController {
    
    var asteriods : Asteriods
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        asteriods = Asteriods()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    var gameView : GameView {
        return view as! GameView
    }
    
    override func loadView() {
        view = GameView()
    }
    
    override func viewDidLoad() {
        gameView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        asteriods.frame = gameView.frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
