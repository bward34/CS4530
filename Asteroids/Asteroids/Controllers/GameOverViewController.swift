//
//  GameOverViewController.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/20/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class GameOverViewController : UIViewController, GameOverViewDelegate {
    
    var currentScore : Int = 0
    var highScores : [HighScore] = []
    var addScore : Bool
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        addScore = true
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    var gameOverView : GameOverView {
        return view as! GameOverView
    }
    
    override func loadView() {
        view = GameOverView()
    }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        gameOverView.gameScore.text = "Your Score: \(currentScore)"
        gameOverView.delegate = self
        if let lastScore = highScores.last?.playerScore {
            if Int(lastScore)! > currentScore && highScores.count == 10 {
                addScore = false
            }
        }
        gameOverView.reloadData()
    }
    
    func goHome(_ gameOverView: GameOverView) {
        
        if addScore {
            let newHighScore : HighScore = HighScore()
            newHighScore.playerName = gameOverView.playerNameField.text!
            newHighScore.playerScore = String(currentScore)
            if highScores.count == 10 {
                highScores.removeLast()
            }
            highScores.append(newHighScore)
            let sortedScores : [HighScore] = highScores.sorted(by: {($0.playerScore as NSString).integerValue > ($1.playerScore as NSString).integerValue })
            
            let documentsDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            do {
                try sortedScores.save(to: documentsDirectory.appendingPathComponent(Constants.scoreList))
            } catch let error where error is Asteriods.Error {
                print(error)
            } catch {
                print(error)
            }
        }
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func checkScore(_ gameOverView: GameOverView) -> Bool {
        return addScore
    }
    
    @objc func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}
