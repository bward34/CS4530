//
//  SwitchViewController.swift
//  Project3 - Project4
//
//  Created by Brandon Ward on 3/2/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class SwitchViewController: UIViewController {
    
    var currentGame : Game?
    
    var switchView: SwitchView {
        return view as! SwitchView
    }
    
    override func loadView()  {
        view = SwitchView()
        
        if currentGame?.winner != Game.Token.none {
            switchView.hitMissLabel.text = "GAME!"
            let player = currentGame?.winner == Game.Token.player1 ? "Player 1" : "Player 2"
            switchView.playerLabel.text = "\(player) wins!"
            switchView.backgroundColor = UIColor.green
        }
        else {
            if currentGame?.currentPlayer == .player1 {
                switchView.playerLabel.text = "It's Player 1's turn!"
            }
            else {
                switchView.playerLabel.text = "It's Player 2's turn!"
            }
            switchView.hitMissLabel.text = currentGame?.hitOrMiss
            
            if(currentGame?.hitOrMiss == "HIT!") {
                switchView.backgroundColor = UIColor.green
            }
            else if currentGame?.hitOrMiss == "MISS!" {
                 switchView.backgroundColor = UIColor.red
            }
            else {
                switchView.backgroundColor = UIColor.blue
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}
