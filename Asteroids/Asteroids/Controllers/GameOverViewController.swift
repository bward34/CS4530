//
//  GameOverViewController.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/20/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class GameOverViewController : UIViewController, GameOverViewDelegate {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    var gameOverView : GameOverView {
        return view as! GameOverView
    }
    
    override func loadView() {
        view = GameOverView()
    }
    
    override func viewDidLoad() {
        gameOverView.delegate = self
    }
    
    func goHome(_ gameOverView: GameOverView) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}
