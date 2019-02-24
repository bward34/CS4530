//
//  Game.swift
//  Project3
//
//  Created by Brandon Ward on 2/23/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import Foundation

class Game {
    
    private enum Token {
        case player1
        case player2
        case water
        case ship5
        case ship4
        case ship3
        case ship2_2
        case ship2_1
        case hit
        case miss
        case none
    }
    
    private var player1Board : [[Token]]
    private var player2Board : [[Token]]
    private var boards : [Token : [[Token]]]
    private var currentPlayer : Token
    private var winner : Token
    private var ships : [ Token : Int ]
    
    init() {
        currentPlayer = .player1
        winner = .none
        
        //initalize board with 10 X 10 of water
        player1Board = [
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],]
        
        player2Board = [
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],
            [.water, .water, .water, .water, .water, .water, .water, .water, .water, .water],]
        
        boards = [ .player1 : player2Board, .player2 : player1Board]
        ships = [.ship5 : 0, .ship4 : 0, .ship3 : 0, .ship2_2 : 0, .ship2_1 : 0]
        
        createBoard()
    }
    
    private func createBoard() {
        
        for(player, _) in boards {
            var shipLength : [Int : Token] = [5 : .ship5, 4 : .ship4, 3 : .ship3, 2 : .ship2_2, 1 : .ship2_1]
            while shipLength.count != 0 {
                
                let col : Int = Int.random(in: 0...9)
                let row : Int = Int.random(in: 0...9)
                let direction : Int = (Int.random(in: 1...10) % 4)
                var removeDict : Bool = false
                
                var currShipLength : Int = shipLength[shipLength.startIndex].key
                let shipToken : Token = shipLength[shipLength.startIndex].value
                
                if(currShipLength == 1) {
                    currShipLength = 2
                }
                print("This is the ship token: \(currShipLength)")
                
                switch direction {
                case 0: //Top
                    if row - (currShipLength - 1) >= 0 {
                        for i in (row - (currShipLength - 1)...row) {
                            if(boards[player]?[col][i] == .water) {
                                boards[player]?[col][i] = shipToken
                                removeDict = true
                            }
                            else {
                                for j in (row - (currShipLength - 1)) ..< i {
                                    boards[player]?[col][j] = .water
                                }
                                removeDict = false
                                break
                            }
                        }
                    }
                    break
                case 1: // Bottom
                    if row + (currShipLength - 1) < 10 {
                        for i in row...(row + (currShipLength - 1)) {
                            if(boards[player]?[col][i] == .water) {
                                boards[player]?[col][i] = shipToken
                                removeDict = true
                            }
                            else {
                                for j in row ..< i {
                                    boards[player]?[col][j] = .water
                                }
                                removeDict = false
                                break
                            }
                        }
                    }
                    break
                case 2: //Left
                    if col - (currShipLength - 1) >= 0 {
                        for i in (col - (currShipLength - 1)...col) {
                            if(boards[player]?[i][row] == .water) {
                                boards[player]?[i][row] = shipToken
                                removeDict = true
                            }
                            else {
                                for j in (col - (currShipLength - 1)) ..< i {
                                    boards[player]?[j][row] = .water
                                }
                                removeDict = false
                                break
                            }
                        }
                    }
                    break
                case 3: //Right
                    if col + (currShipLength - 1) < 10 {
                        for i in col...(col + currShipLength - 1) {
                            if(boards[player]?[i][row] == .water) {
                                boards[player]?[i][row] = shipToken
                                removeDict = true
                            }
                            else {
                                for j in col ..< i {
                                    boards[player]?[j][row] = .water
                                }
                                
                                removeDict = false
                                break
                                
                            }
                        }
                    }
                    break
                default:
                    break
                }
                if(removeDict) {
                    shipLength.removeValue(forKey: currShipLength)
                }
            }
        }
        
        printDict()
        
        
    }
    
    func takeTurn(at col: Int, and row: Int) {
        if(boards[currentPlayer]?[col][row] != .water) {
            //check which ships was hit
            boards[currentPlayer]?[col][row] = .hit
        }
        else {
            boards[currentPlayer]?[col][row] = .miss
        }
        
        if(currentPlayer == .player1) {
            currentPlayer = .player2
        }
        else {
            currentPlayer = .player1
        }
        
        //TODO: Determine winner
    }
    
    //A debugger method
    private func printDict() {
        for (_, board) in boards {
            print("board")
            for x in 0 ..< board.count {
                var data : String = ""
                for y in 0 ..< board[x].count {
                    if(board[x][y] == .water) {
                        data = data + " 0"
                    }
                    else if(board[x][y] == .ship5) {
                        data = data + " 5"
                    }
                    else if(board[x][y] == .ship4) {
                        data = data + " 4"
                    }
                    else if(board[x][y] == .ship3) {
                         data = data + " 3"
                    }
                    else if(board[x][y] == .ship2_2) {
                       data = data + " 2"
                    }
                    else if(board[x][y] == .ship2_1) {
                        data = data + " 1"
                    }
                }
                print(data)
            }
        }
    }

}
