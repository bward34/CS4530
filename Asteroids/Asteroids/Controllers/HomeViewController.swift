//
//  HomeViewController.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/6/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class HomeViewController : UIViewController, HomeViewDelegate {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    var homeView : HomeView {
        return view as! HomeView
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        homeView.delegate = self
    }
    
    func showNewGame(_ homeView: HomeView) {
        let newGameViewController = GameViewController()
        present(newGameViewController, animated: true, completion: nil)
    }
    
    func showHighScore(_ homeView: HomeView) {
        let highScoreViewController = HighScoreViewController()
        present(highScoreViewController, animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
