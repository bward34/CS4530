//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Brandon Ward on 2/20/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameViewDelegate {
    
    var game: Game = Game()
    
    //TODO: Define data model (an instance of game)
    
    var gameView: GameView {
        return view as! GameView
    }
    
    override func loadView() {
        view = GameView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameView.reloadData()
        gameView.delegate = self
    }
    
    func gameView(_gameView: GameView, tokenFor col: Int, and row: Int) -> String {
        var token: String
        
        switch(game.board[col][row]) {
            case .none : token = "😅"
            case .red : token = "😍"
            case .blue : token = "😀"
        }
        return token
    }
    
    func gameView(_gameView: GameView, cellTouchedAt col: Int, and row: Int) {
        <#code#>
    }
    
}

