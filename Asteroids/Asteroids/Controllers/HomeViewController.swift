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
    var highScores : [HighScore] = []
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        checkGameState()
    }
    
    func showNewGame(_ homeView: HomeView) {
        let newGameViewController = GameViewController()
        if game != nil {
            newGameViewController.asteriods = game!
        }
        else {
            newGameViewController.asteriods = Asteriods()
        }
        newGameViewController.highScores = highScores
        present(newGameViewController, animated: true, completion: nil)
    }
    
    func showHighScore(_ homeView: HomeView) {
        let highScoreViewController = HighScoreViewController()
        highScoreViewController.highScores = highScores
        present(highScoreViewController, animated: true, completion: nil)
    }
    
    func checkGameState() {
        if !UserDefaults.standard.bool(forKey: "hasLoggedIn") {
            UserDefaults.standard.set(true, forKey: "hasLoggedIn")
        }
        else {
            let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let jsonData = try! Data(contentsOf: documentDirectory.appendingPathComponent(Constants.gamesList))
            game = try! JSONDecoder().decode(Asteriods.self, from: jsonData)
            let scoreJsonData = try! Data(contentsOf: documentDirectory.appendingPathComponent(Constants.scoreList))
            highScores = try! JSONDecoder().decode([HighScore].self, from: scoreJsonData)
        }
        
        if game != nil {
            if game!.gameComplete {
                homeView.newGameButton.setTitle("New Game", for: .normal)
                game = Asteriods()
            }
            else {
              homeView.newGameButton.setTitle("Resume Game", for: .normal)
            }
        }
        else {
            homeView.newGameButton.setTitle("New Game", for: .normal)
            game = Asteriods()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
