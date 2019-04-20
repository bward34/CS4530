//
//  GameOverViewController.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/20/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class GameOverViewController : UIViewController {
    
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
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}
