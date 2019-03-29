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
    var gameId : String
    var playerId : String
   // var status : String
    var winner : String
    var myTurn : Bool
    var statusTimer : Timer?
    var turnTimer: Timer?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        game = Game()
        gameId = ""
        playerId = ""
       // status = ""
        myTurn = true
        winner = ""
        statusTimer = Timer()
        turnTimer = Timer()
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
       // statusTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(getGameStatus), userInfo: nil, repeats: true)
        turnTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(getTurnInfo), userInfo: nil, repeats: true)
        loadGameBoards()
        getTurnInfo()
       // getGameStatus()
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
        case .ship?: cell = "⛴"
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
        
        if myTurn == true {
            myTurn = false
            let webURL = URL(string: "http://174.23.159.139:2142/api/games/\(gameId)")!
            var postRequest = URLRequest(url: webURL)
            postRequest.httpMethod = "POST"
            let dataString: [String: Any] = ["playerId": playerId, "xPos": col, "yPos": row]
            let jsonData: Data
            do {
                jsonData = try JSONSerialization.data(withJSONObject: dataString, options: [])
                postRequest.httpBody = jsonData
            } catch {
                print("Error: can not create json string")
                return
            }
            
            let task = URLSession.shared.dataTask(with: postRequest) { [weak self] (data, response, error) in
                guard error == nil else {
                    fatalError("URL failed: \(error!)")
                }
                guard let data = data,
                    let dataString = String(bytes: data, encoding: .utf8)
                    else {
                        print("No data to work with.")
                        return
                }
                guard let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode)
                    else {
                        print("Network Error")
                        return
                }
                print(dataString)
                if let hitMissInfo = try! JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                    DispatchQueue.main.async { [weak self] in
                        let hit = hitMissInfo["hit"] as! Bool
                        let sunk = hitMissInfo["shipSunk"] as! Int
                        let newSwitchViewController: SwitchViewController = SwitchViewController()
                        if sunk != 0 {
                            newSwitchViewController.hitMiss = "SUNK!"
                        }
                        else if !hit {
                            newSwitchViewController.hitMiss = "MISS!"
                        }
                        else {
                            newSwitchViewController.hitMiss = "HIT!"
                        }
                        self?.loadGameBoards()
                        self?.turnTimer = Timer.scheduledTimer(timeInterval: 2, target: self!, selector: #selector(self?.getTurnInfo), userInfo: nil, repeats: true)
                        self?.present(newSwitchViewController, animated: true, completion: nil)
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func game(_ game: Game, cellChangedAt col: Int, and row: Int) {
      let newSwitchViewController: SwitchViewController = SwitchViewController()
      present(newSwitchViewController, animated: true, completion: nil)
    }
    
    func gameView(_ gameView: GameView) {
        if turnTimer != nil {
            turnTimer?.invalidate()
            turnTimer = nil
        }
        if statusTimer != nil {
            statusTimer?.invalidate()
            statusTimer = nil
        }
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func loadGameBoards() {
        let webURL = URL(string: "http://174.23.159.139:2142/api/games/\(gameId)/boards?playerId=\(playerId)")!
        let task = URLSession.shared.dataTask(with: webURL) { [weak self] (data, response, error) in
            guard error == nil else {
                fatalError("URL dataTask failed: \(error!)")
            }
            guard let data = data,
                let _ = String(bytes: data, encoding: .utf8)
                else {
                    print("No data to work with.")
                    return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode)
                else {
                    print("Network Error")
                    return
            }
            self?.game = try! JSONDecoder().decode(Game.self, from: data)
            DispatchQueue.main.async { [weak self] in
                self?.gameView.reloadData()
            }
        }
        task.resume()
    }
    
//    @objc func getGameStatus() {
//        let webURL = URL(string: "http://174.23.159.139:2142/api/lobby/\(gameId)")!
//        let task = URLSession.shared.dataTask(with: webURL) { [weak self] (data, response, error) in
//            guard error == nil else {
//                fatalError("URL dataTask failed: \(error!)")
//            }
//            guard let data = data,
//                let dataString = String(bytes: data, encoding: .utf8)
//
//                else {
//                    print("No data returned")
//                    return
//            }
//            guard let response = response as? HTTPURLResponse,
//                (200...299).contains(response.statusCode)
//                else {
//                    print("Network Error: Game Status")
//                    return
//            }
//            print(dataString)
//            if let turnInfo = try! JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
//                DispatchQueue.main.async { [weak self] in
//                    self?.status = turnInfo["status"] as! String
//                    if self?.status == "PLAYING" {
//                        if self?.statusTimer != nil {
//                            self?.statusTimer?.invalidate()
//                            self?.statusTimer = nil
//                        }
//                        self?.gameView.reloadData()
//                        self?.gameView.backgroundColor = .gray
//                    }
//                    else {
//                        self?.gameView.infoLabel.text = "Waiting..."
//                    }
//                    self?.gameView.reloadData()
//                }
//            }
//        }
//        task.resume()
//    }
    
   @objc func getTurnInfo() {
        let webURL = URL(string: "http://174.23.159.139:2142/api/games/\(gameId)?playerId=\(playerId)")!
        let task = URLSession.shared.dataTask(with: webURL) { [weak self] (data, response, error) in
            guard error == nil else {
                fatalError("URL dataTask failed: \(error!)")
            }
            guard let data = data,
                let dataString = String(bytes: data, encoding: .utf8)
                
                else {
                    //fatalError("no data to work with")
                    print("No data returned")
                    return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode)
                else {
                    print("Network Error: Game turns")
                    return
            }
            print(dataString)
            if let turnInfo = try! JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                DispatchQueue.main.async { [weak self] in
                    self?.myTurn = turnInfo["isYourTurn"] as! Bool
                    self?.winner = turnInfo["winner"] as! String
                    if (self?.myTurn)! {
                        self?.gameView.infoLabel.text = "Your turn!"
                        self?.gameView.backgroundColor = .lightGray
                        if self?.turnTimer != nil {
                            self?.turnTimer?.invalidate()
                            self?.turnTimer = nil
                        }
                        self?.loadGameBoards()
                        self?.gameView.reloadData()
                    }
                    else if !(self?.myTurn)! {
                         self?.gameView.infoLabel.text = "Other player's turn!"
                           self?.gameView.backgroundColor = .gray
                    }
                    self?.gameView.reloadData()
                }
            }
        }
        task.resume()
    }
}
