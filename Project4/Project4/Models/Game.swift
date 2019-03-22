//
//  Game.swift
//  Project3
//
//  Created by Brandon Ward on 2/23/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import Foundation

protocol GameDelegate {
    func game(_ game: Game, cellChangedAt col: Int, and row: Int)
}

class Game: Codable {
    
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
    
    private var player1Board : [[Token]] = [[]]
    private var player2Board : [[Token]] = [[]]
    private var shipCount : [Token : [ Token : Int ]] = [.player1 : [:], .player2 : [:]]
    
    var shipsSunk : [Token : [ Token : Bool]] = [.player1 : [:], .player2 : [:]]
    var boards : [Token : [[Token]]] = [.player1 : [], .player2 : []]
    var currentPlayer : Token = .none
    var winner : Token = .none
    var hitOrMiss : String = ""
    
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
        //printDict()
    }
    
    
    /**
     A function called when the current player takes their turn. Determines
     a hit or miss by the board dictionary object
     - parameters:
        - col: The column which the user takes turn at.
        - row: The row which the user takes turn at.
    */
    func takeTurn(at col: Int, and row: Int) {
        if(winner == .none) {
            let player : Token = currentPlayer == .player1 ? .player2: .player1
            if boards[player]?[row][col] != .water  && boards[player]?[row][col] != .hit && boards[player]?[row][col] != .miss {
                hitOrMiss = "HIT!"
                updateShipCount(player: player, ship: boards[player]![row][col], currentPlayer: currentPlayer)
                boards[player]?[row][col] = .hit
            }
            else if  boards[player]?[row][col] == .water {
                boards[player]?[row][col] = .miss
                hitOrMiss = "MISS!"
            }
            else if boards[player]?[row][col] == .hit {
                 hitOrMiss = "HIT!"
            }
            else {
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
    }
    
    private func updateShipCount(player: Token, ship: Token, currentPlayer: Token) {
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
        
        //Check if there is a winner yet
        if shipCount[player]?[ship, default: 0] == 0 {
            shipsSunk[player]?[ship, default: false] = true
            hitOrMiss = "SUNK!"
            var shipSunk = 0
            for(_, sunk) in shipsSunk[player]! {
                if sunk {
                    shipSunk += 1
                }
            }
            if shipSunk == 5 {
                winner = currentPlayer
            }
        }
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: GameKeys.self)
        let winnerToken = try values.decode(String.self, forKey: Game.GameKeys.winner)
        let currentPlayerToken = try values.decode(String.self, forKey: Game.GameKeys.currentPlayer)
        let boardToken = try values.decode([String : [[String]]].self, forKey: Game.GameKeys.boards)
        let shipCountToken = try values.decode([String : [String : Int ]].self, forKey: Game.GameKeys.shipCount)
        let shipSunkToken = try values.decode([String : [String : Bool ]].self, forKey: Game.GameKeys.shipSunk)
        
        if (winnerToken == "player1") {
            winner = .player1
        }
        else if winnerToken == "player2" {
            winner = .player2
        }
        else {
            winner = .none
        }
        
        if (currentPlayerToken == "player1") {
            currentPlayer = .player1
        }
        else {
            currentPlayer = .player2
        }
        
        boards = decodePlayerBoard(stringDict: boardToken)
        shipCount = decodeShipCount(shipCountString: shipCountToken)
        shipsSunk = decodeShipSunk(shipSunkString: shipSunkToken)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GameKeys.self)
        var winnerString = ""
        var currentPlayerString = ""
        var shipCountDictString : [String : [String : Int]]
        var shipBoolDictString : [String : [String : Bool]]
        var boardsDictString : [String: [[String]]]
        
        shipCountDictString = encodeShipCount()
        shipBoolDictString = encodeShipSunk()
        boardsDictString = encodePlayerBoard()
        
        if winner == .player1 {
            winnerString = "player1"
        }
        else if winner == .player2 {
            winnerString = "player2"
        }
        else {
            winnerString = "none"
        }
        
        if currentPlayer == .player1 {
            currentPlayerString = "player1"
        }
        else {
            currentPlayerString = "player2"
        }
        
        try container.encode(shipCountDictString, forKey: Game.GameKeys.shipCount)
        try container.encode(shipBoolDictString, forKey: Game.GameKeys.shipSunk)
        try container.encode(boardsDictString, forKey: Game.GameKeys.boards)
        try container.encode(winnerString, forKey: Game.GameKeys.winner)
        try container.encode(currentPlayerString, forKey: Game.GameKeys.currentPlayer)
        
    }
    
    enum Error: Swift.Error {
        case encoding
        case writing
    }
    
    enum GameKeys: CodingKey {
        case boards
        case currentPlayer
        case shipCount
        case shipSunk
        case winner
    }
    
    /**
     A method for converting the boards dictionary to strings for
     encoding.
     - returns: A dictionary for encoding.
     */
    func encodePlayerBoard() ->  [String : [[String]]] {
        var boardsString : [String : [[String]]] = [:]
        for(player, board) in boards {
            var boardItems : [[String]] = []
            for x in 0 ..< board.count {
                var rowColStrings : [String] = []
                for y in 0 ..< board[x].count {
                    var tokenString : String = ""
                    switch board[x][y] {
                    case .water:
                        tokenString = "water"
                        break
                    case .hit:
                        tokenString = "hit"
                        break
                    case .miss:
                        tokenString = "miss"
                        break
                    case .ship2_1:
                        tokenString = "ship2_1"
                        break
                    case .ship2_2:
                        tokenString = "ship2_2"
                        break
                    case .ship3:
                        tokenString = "ship3"
                        break
                    case .ship4:
                        tokenString = "ship4"
                        break
                    case .ship5:
                        tokenString = "ship5"
                        break
                    default :
                        break
                    }
                    rowColStrings.append(tokenString)
                }
                boardItems.append(rowColStrings)
            }
           let playerString = player == .player1 ? "player1" : "player2"
           boardsString.updateValue(boardItems, forKey: playerString)
        }
        return boardsString
    }
    
    /**
     A method for converting the shipsCount dictionary to strings for
     encoding.
     - returns: A dictionary for encoding.
     */
    func encodeShipCount() -> [String : [String : Int]] {
        var shipCountString : [String : [String : Int]] = [:]
        for (player, countDict) in shipCount {
            var shipCountDict : [String : Int] = [:]
            for(ship, count) in countDict {
                var shipString = ""
                var countAdd = 0
                switch ship {
                case .ship2_1 : shipString = "ship2_1"
                                countAdd = count
                    break
                case .ship2_2 :  shipString = "ship2_2"
                                 countAdd = count
                    break
                case .ship3 : shipString = "ship3"
                              countAdd = count
                    break
                case .ship4 : shipString = "ship4"
                              countAdd = count
                    break
                case .ship5 : shipString = "ship5"
                              countAdd = count
                default :
                    break
                }
                shipCountDict.updateValue(countAdd, forKey: shipString)
            }
            let playerString = player == .player1 ? "player1" : "player2"
            shipCountString.updateValue(shipCountDict, forKey: playerString)
        }
        return shipCountString
    }
    
    /**
     A method for converting the shipsSunk dictionary to strings for
     encoding.
     - returns: A dictionary for encoding.
    */
    func encodeShipSunk() -> [String : [String : Bool]] {
        var shipSunkString : [String : [String : Bool]] = [:]
        for (player, boolDict) in shipsSunk {
            var shipBoolDict : [String : Bool] = [:]
            for(ship, boolVal) in boolDict {
                var shipString = ""
                var boolAdd = false
                switch ship {
                case .ship2_1 : shipString = "ship2_1"
                                boolAdd = boolVal
                    break
                case .ship2_2 :  shipString = "ship2_2"
                                boolAdd = boolVal
                    break
                case .ship3 : shipString = "ship3"
                                boolAdd = boolVal
                    break
                case .ship4 : shipString = "ship4"
                                boolAdd = boolVal
                    break
                case .ship5 : shipString = "ship5"
                                boolAdd = boolVal
                default :
                    break
                }
                shipBoolDict.updateValue(boolAdd, forKey: shipString)
            }
            let playerString = player == .player1 ? "player1" : "player2"
            shipSunkString.updateValue(shipBoolDict, forKey: playerString)
        }
        return shipSunkString
    }
    
    /**
     A method for converting the boards dictionary to tokens for
     decoding.
     - returns: A dictionary for encoding.
     */
    func decodePlayerBoard(stringDict : [String : [[String]]]) ->  [Token : [[Token]]] {
        var boardsToken : [Token : [[Token]]] = [.player1 : [], .player2 : []]
        for(player, board) in stringDict {
            var boardItems : [[Token]] = []
            for x in 0 ..< board.count {
                var rowColTokens : [Token] = []
                for y in 0 ..< board[x].count {
                    var newToken : Token = .none
                    switch board[x][y] {
                    case "water":
                        newToken = .water
                        break
                    case "hit":
                        newToken = .hit
                        break
                    case "miss":
                        newToken = .miss
                        break
                    case "ship2_1":
                        newToken = .ship2_1
                        break
                    case "ship2_2":
                        newToken = .ship2_2
                        break
                    case "ship3":
                        newToken = .ship3
                        break
                    case "ship4":
                        newToken = .ship4
                        break
                    case "ship5":
                        newToken = .ship5
                        break
                    default :
                        break
                    }
                    rowColTokens.append(newToken)
                }
                boardItems.append(rowColTokens)
            }
            let playerToken = player == "player1" ? Game.Token.player1 : Game.Token.player2
            boardsToken.updateValue(boardItems, forKey: playerToken)
        }
        return boardsToken
    }
    
    /**
     A method for converting the shipsCount dictionary to tokens for
     decoding
     - returns: A dictionary for encoding.
     */
    func decodeShipCount(shipCountString : [String : [String : Int]]) -> [Token : [Token : Int]] {
        var shipCount : [Token : [Token : Int]] = [:]
        for (player, countDict) in shipCountString {
            var shipCountDict : [Token : Int] = [:]
            for(ship, count) in countDict {
                var shipToken = Game.Token.none
                var countAdd = 0
                switch ship {
                case "ship2_1" : shipToken = .ship2_1
                                countAdd = count
                    break
                case "ship2_2" : shipToken = .ship2_2
                                countAdd = count
                    break
                case "ship3" : shipToken = .ship3
                               countAdd = count
                    break
                case "ship4" : shipToken = .ship4
                               countAdd = count
                    break
                case "ship5" : shipToken = .ship5
                               countAdd = count
                default :
                    break
                }
                shipCountDict.updateValue(countAdd, forKey: shipToken)
            }
            let playerToken = player == "player1" ? Game.Token.player1 : Game.Token.player2
            shipCount.updateValue(shipCountDict, forKey: playerToken)
        }
        return shipCount
    }
    
    /**
     A method for converting the shipsSunk dictionary to tokens for
     decoding.
     - returns: A dictionary for encoding.
     */
    func decodeShipSunk(shipSunkString: [String : [String : Bool]]) -> [Token : [Token : Bool]] {
        var shipSunkToken : [Token : [Token : Bool]] = [:]
        for (player, boolDict) in shipSunkString {
            var shipBoolDict : [Token : Bool] = [:]
            for(ship, boolVal) in boolDict {
                var shipString = Game.Token.none
                var boolAdd = false
                switch ship {
                case "ship2_1" : shipString = .ship2_1
                                 boolAdd = boolVal
                    break
                case "ship2_2" :  shipString = .ship2_2
                                  boolAdd = boolVal
                    break
                case "ship3" : shipString = .ship3
                               boolAdd = boolVal
                    break
                case "ship4" : shipString = .ship4
                               boolAdd = boolVal
                    break
                case "ship5" : shipString = .ship5
                               boolAdd = boolVal
                default :
                    break
                }
                shipBoolDict.updateValue(boolAdd, forKey: shipString)
            }
            let playerString = player == "player1" ? Game.Token.player1 : Game.Token.player2
            shipSunkToken.updateValue(shipBoolDict, forKey: playerString)
        }
        return shipSunkToken
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

extension Array where Element == Game {
    func save(to url: URL) throws {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            throw Game.Error.encoding
        }
        guard (try? jsonData.write(to: url)) != nil else {
            throw Game.Error.writing
        }
        
    }
    
    init(from url: URL) throws {
        let jsonData = try! Data(contentsOf: url)
        self = try JSONDecoder().decode([Game].self, from: jsonData)
    }
}
