//
//  GameViewController.swift
//  Project3
//
//  Created by Brandon Ward on 2/23/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameViewDelegate, GameDelegate {
    
    var gamesList : [Game] = []
    var game: Game
    var gameIndex : Int = 0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        game = Game()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        game.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var gameView: GameView {
        return view as! GameView
    }
    override func loadView()  {
        view = GameView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.delegate = self
        gameView.dataSource = self
        gameView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let documentsDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        do {
            try gamesList.save(to: documentsDirectory.appendingPathComponent(Constants.gamesList))
        } catch let error where error is Game.Error {
            print(error)
        } catch {
              print(error)
        }
        gameView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIApplication.shared.statusBarOrientation.isPortrait {
            gameView.isPortrait = false
        }
        else if UIApplication.shared.statusBarOrientation.isLandscape {
            gameView.isPortrait = true
        }
        gameView.setNeedsDisplay()
    }
    
    func gameView(_ gameView: GameView, currentPlayerTokens col: Int, and row: Int) -> String{
        var cell : String
        switch(game.boards[game.currentPlayer]?[row][col]) {
        case .water?: cell = ""
            break
        case .hit?: cell = "✅"
            break
        case .miss?: cell = "❌"
            break
        case .ship2_1?: cell = "🚤"
            break
        case .ship2_2?: cell = "🛥"
            break
        case .ship3?: cell = "🛳"
            break
        case .ship4?: cell = "🚢"
            break
        case .ship5?: cell = "⛴"
            break
        default: cell = ""
        }
        
        return cell
    }
    
    func gameView(_ gameView: GameView, otherPlayerTokens col: Int, and row: Int) -> String{
        let player : Game.Token = game.currentPlayer == .player1 ? Game.Token.player2 : Game.Token.player1
        var cell : String
        switch game.boards[player]?[row][col] {
        case .water?: cell = ""
            break
        case .hit?: cell = "✅"
            break
        case .miss?: cell = "❌"
            break
        default:
            cell = ""
        }
        return cell
    }
    
    func gameView(_ gameView: GameView, cellTouchedAt col: Int, and row: Int) {
        game.takeTurn(at: col, and: row)
    }
    
    func game(_ game: Game, cellChangedAt col: Int, and row: Int) {
        let newSwitchViewController: SwitchViewController = SwitchViewController()
        newSwitchViewController.currentGame = game
        gamesList[gameIndex] = game
        let documentsDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        do {
            try gamesList.save(to: documentsDirectory.appendingPathComponent(Constants.gamesList))
        } catch let error where error is Game.Error {
              print(error)
        } catch {
              print(error)
        }
      present(newSwitchViewController, animated: true, completion: nil)
    }
    
    func gameView(_ gameView: GameView) {
        gamesList[gameIndex] = game
        let documentsDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        do {
            try gamesList.save(to: documentsDirectory.appendingPathComponent(Constants.gamesList))
        } catch let error where error is Game.Error {
            print(error)
        } catch {
            print(error)
        }
        dismiss(animated: true, completion: nil)
    }
    
}
