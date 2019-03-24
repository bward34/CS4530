//
//  GameViewController.swift
//  Project3 - Project4
//
//  Created by Brandon Ward on 2/23/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameViewDelegate, GameDelegate {
    
    var game : Game
    var gameId : String?
    var nameId : String?
    
    var gameIndex : Int = 0
    var gamesList : [Game] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        game = Game()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        game.delegate = self
        
        let webURL = URL(string: "http://174.23.159.139:2142/api/games/b3feb43e-a998-4d14-94eb-df12dc41bd33/boards?playerId=7776d3b6-7887-40b2-a9bc-2a4f47dd5e1f")!
        let task = URLSession.shared.dataTask(with: webURL) { [weak self] (data, response, error) in
            guard error == nil else {
                fatalError("URL dataTask failed: \(error!)")
            }
            guard let data = data,
                let dataString = String(bytes: data, encoding: .utf8)
                else {
                    fatalError("no data to work with")
            }
            print(dataString)
            self?.game = try! JSONDecoder().decode(Game.self, from: data)
            DispatchQueue.main.async { [weak self] in
                self?.gameView.reloadData()
            }
        }
        task.resume()
        
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
//        do {
//            try gamesList.save(to: documentsDirectory.appendingPathComponent(Constants.gamesList))
//        } catch let error where error is Game.Error {
//            print(error)
//        } catch {
//              print(error)
//        }
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
        switch(game.boards[Game.Token.playerBoard]?[row][col]) {
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
        let player : Game.Token = Game.Token.opponentBoard
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
//        do {
//            try gamesList.save(to: documentsDirectory.appendingPathComponent(Constants.gamesList))
//        } catch let error where error is Game.Error {
//              print(error)
//        } catch {
//              print(error)
//        }
      present(newSwitchViewController, animated: true, completion: nil)
    }
    
    func gameView(_ gameView: GameView) {
//        gamesList[gameIndex] = game
//        let documentsDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        do {
//            try gamesList.save(to: documentsDirectory.appendingPathComponent(Constants.gamesList))
//        } catch let error where error is Game.Error {
//            print(error)
//        } catch {
//            print(error)
//        }
        dismiss(animated: true, completion: nil)
    }
    
}
