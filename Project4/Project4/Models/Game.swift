//
//  Game.swift
//  Project3 - Project4
//
//  Created by Brandon Ward on 2/23/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import Foundation

struct GameCordinate: Codable {
    var xPos: Int
    var yPos: Int
    var status: String
}

protocol GameDelegate {
    func game(_ game: Game, cellChangedAt col: Int, and row: Int)
}

class Game: Decodable {

    enum Token {
        case opponentBoard
        case playerBoard
        case water
        case ship
        case hit
        case miss
        case none
    }
    
    var delegate : GameDelegate?
    
    private var player1Board : [[Token]] = [[]]
    private var player2Board : [[Token]] = [[]]
    var boards : [Token : [[Token]]] = [.playerBoard : [], .opponentBoard : []]
    
    init() {
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
        
        boards = [.opponentBoard : player2Board, .playerBoard: player1Board]
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: GameKeys.self)
        let opponentBoard = try values.decode([GameCordinate].self, forKey: Game.GameKeys.opponentBoard)
        let playerBoard =   try values.decode([GameCordinate].self, forKey: Game.GameKeys.playerBoard)

        boards = decodeBoards(opponentBoard: opponentBoard, playerBoard: playerBoard)     
    }
    
    func decodeBoards(opponentBoard : [GameCordinate], playerBoard : [GameCordinate]) ->  [Token : [[Token]]]  {
        var boardsToken : [Token : [[Token]]] = [.playerBoard :  Array(repeating: Array(repeating: .water, count: 10), count: 10), .opponentBoard : Array(repeating: Array(repeating: .water, count: 10), count: 10)]
        for gameCoordinate in opponentBoard {
            var token : Token = .none
            switch gameCoordinate.status {
                case "NONE":
                    token = .water
                    break
                case "HIT":
                    token = .hit
                    break
                case "MISS":
                    token = .miss
                    break
                default:
                 token = .water
                
            }
            boardsToken[.opponentBoard]?[gameCoordinate.yPos][gameCoordinate.xPos] = token
        }
        for gameCoordinate in playerBoard {
            var token : Token = .none
            switch gameCoordinate.status {
            case "NONE":
                token = .water
                break
            case "HIT":
                token = .hit
                break
            case "MISS":
                token = .miss
                break
            case "SHIP":
                token = .ship
                break
            default:
                token = .water
                
            }
            boardsToken[.playerBoard]?[gameCoordinate.yPos][gameCoordinate.xPos] = token
        }
        return boardsToken
    }

    enum Error: Swift.Error {
        case encoding
        case writing
    }

    enum GameKeys: CodingKey {
        case opponentBoard
        case playerBoard
    }
}

extension Array where Element == Game {

    init(from url: URL) throws {
        let jsonData = try! Data(contentsOf: url)
        self = try JSONDecoder().decode([Game].self, from: jsonData)
    }
}
