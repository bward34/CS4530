//
//  Game.swift
//  Project3
//
//  Created by Brandon Ward on 2/23/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

protocol GameDelegate {
    func game(_ game: Game, cellChangedAt col: Int, and row: Int)
   // func winner
}

class Game {
    
    enum Token {
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
    
    var delegate : GameDelegate?
    
    private var player1Board : [[Token]]
    private var player2Board : [[Token]]
    private var winner : Token
    private var shipCount : [Token : [ Token : Int ]]
    private var shipsSunk : [Token : [ Token : Bool]]
    
    var boards : [Token : [[Token]]]
    var currentPlayer : Token
    var hitOrMiss : String
    
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
        shipCount = [.player1 : [.ship5 : 5, .ship4 : 4, .ship3 : 3, .ship2_2 : 2, .ship2_1 : 2],
                     .player2 : [.ship5 : 5, .ship4 : 4, .ship3 : 3, .ship2_2 : 2, .ship2_1 : 2]]
        shipsSunk = [.player1 : [.ship5 : false, .ship4 : false, .ship3 : false, .ship2_2 : false, .ship2_1 : false],
                     .player2 : [.ship5 : false, .ship4 : false, .ship3 : false, .ship2_2 : false, .ship2_1 : false]]
        hitOrMiss = ""
        
        createBoard()
    }
    
    /**
     A function for creating the two player's board objects.
    */
    private func createBoard() {
        
        for(player, _) in boards {
            var shipLength : [Token : Int] = [.ship5 : 5, .ship4 : 4, .ship3 : 3, .ship2_2 : 2, .ship2_1 : 2]
            while shipLength.count != 0 {
                
                let col : Int = Int.random(in: 0...9)
                let row : Int = Int.random(in: 0...9)
                let direction : Int = (Int.random(in: 1...10) % 4)
                var removeShip : Bool = false
                
                let currShipLength : Int = shipLength[shipLength.startIndex].value
                let shipToken : Token = shipLength[shipLength.startIndex].key
                
                switch direction {
                case 0: //Top
                    if row - (currShipLength - 1) >= 0 {
                        for i in (row - (currShipLength - 1)...row) {
                            if(boards[player]?[i][col] == .water) {
                                boards[player]?[i][col] = shipToken
                                removeShip = true
                            }
                            else {
                                for j in (row - (currShipLength - 1)) ..< i {
                                    boards[player]?[j][col] = .water
                                }
                                removeShip = false
                                break
                            }
                        }
                    }
                    break
                case 1: // Bottom
                    if row + (currShipLength - 1) < 10 {
                        for i in row...(row + (currShipLength - 1)) {
                            if(boards[player]?[i][col] == .water) {
                                boards[player]?[i][col] = shipToken
                                removeShip = true
                            }
                            else {
                                for j in row ..< i {
                                    boards[player]?[j][col] = .water
                                }
                                removeShip = false
                                break
                            }
                        }
                    }
                    break
                case 2: //Left
                    if col - (currShipLength - 1) >= 0 {
                        for i in (col - (currShipLength - 1)...col) {
                            if(boards[player]?[row][i] == .water) {
                                boards[player]?[row][i] = shipToken
                                removeShip = true
                            }
                            else {
                                for j in (col - (currShipLength - 1)) ..< i {
                                    boards[player]?[row][j] = .water
                                }
                                removeShip = false
                                break
                            }
                        }
                    }
                    break
                case 3: //Right
                    if col + (currShipLength - 1) < 10 {
                        for i in col...(col + currShipLength - 1) {
                            if(boards[player]?[row][i] == .water) {
                                boards[player]?[row][i] = shipToken
                                removeShip = true
                            }
                            else {
                                for j in col ..< i {
                                    boards[player]?[row][j] = .water
                                }
                                removeShip = false
                                break
                            }
                        }
                    }
                    break
                default:
                    break
                }
                if(removeShip) {
                    shipLength.removeValue(forKey: shipToken)
                }
            }
        }
        
        printDict()
    }
    
    
    /**
     A function called when the current player takes their turn. Determines
     a hit or miss by the board dictionary object
     - parameters:
        - col: The column which the user takes turn at.
        - row: The row which the user takes turn at.
    */
    func takeTurn(at col: Int, and row: Int) {
        let player : Token = currentPlayer == .player1 ? .player2: .player1
        if boards[player]?[row][col] != .water  && boards[player]?[row][col] != .hit && boards[player]?[row][col] != .miss {
            hitOrMiss = "HIT!"
            updateShipCount(player: currentPlayer, ship: boards[player]![row][col])
            boards[player]?[row][col] = .hit
        }
        else if boards[player]?[row][col] != .hit {
            boards[player]?[row][col] = .miss
            hitOrMiss = "MISS!"
        }
        
        if(currentPlayer == .player1) {
            currentPlayer = .player2
        }
        else {
            currentPlayer = .player1
        }
        delegate?.game(self, cellChangedAt: col, and: row)
    }
    
    private func updateShipCount(player: Token, ship: Token) {
        switch ship {
        case .ship2_1:
            shipCount[player]?[ship, default: 0] -= 1
            break
        case .ship2_2:
            shipCount[player]?[ship, default: 0] -= 1
            break
        case .ship3:
            shipCount[player]?[ship, default: 0] -= 1
            break
        case .ship4:
            shipCount[player]?[ship, default: 0] -= 1
            break
        case .ship5:
            shipCount[player]?[ship, default: 0] -= 1
            break
        default:
            break
        }
        
        if shipCount[player]?[ship, default: 0] == 0 {
            shipsSunk[player]?[ship, default: false] = true
            hitOrMiss = "SUNK!"
        }
    }
    
    /**
     A debugger method for printing the created game board from the game object.
     */
    private func printDict() {
        for (player, board) in boards {
            if(player == .player1) {
              print("player1's")
            }
            else {
                print("player2's")
            }
     
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
