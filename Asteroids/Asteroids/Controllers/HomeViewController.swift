//
//  HomeViewController.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/6/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class HomeViewController : UIViewController, HomeViewDelegate {
    var game : Asteriods?
    
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
        
        if !UserDefaults.standard.bool(forKey: "gameCreated") {
            homeView.newGameButton.setTitle("New Game", for: .normal)
        }
        else {
            homeView.newGameButton.setTitle("Resume Game", for: .normal)
            let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let jsonData = try! Data(contentsOf: documentDirectory.appendingPathComponent(Constants.gamesList))
            game = try! JSONDecoder().decode(Asteriods.self, from: jsonData)
        }
        homeView.delegate = self
    }
    
    func showNewGame(_ homeView: HomeView) {
        let newGameViewController = GameViewController()
        if game != nil {
            newGameViewController.asteriods = game!
        }
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
