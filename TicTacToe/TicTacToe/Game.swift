//
//  Game.swift
//  TicTacToe
//
//  Created by Brandon Ward on 2/20/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

class Game {
    
    enum Token {
        case none
        case red
        case blue
    }
    var board: [[Token]] = [
        [.none, .none, .none],
        [.none, .none, .none],
        [.none, .none, .none]]
    
    var currentPlayer: Token = .red
    var winner: Token = .none
    
    func takeTurn(at col: Int, and row: Int) {
        //Claim a cell for a current player
        if(board[col][row] == .none) {
        board[col][row] = currentPlayer
            if currentPlayer == .red {
                currentPlayer = .blue
            }
            else {
                currentPlayer = .red
            }
            
        }
        
        //TODO: Determine winner
    }
}
