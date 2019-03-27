//
//  GameStatsViewController.swift
//  Project4
//
//  Created by Brandon Ward on 3/27/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

struct GameStats: Codable {
    var id : String
    var name : String
    var player1 : String
    var player2 : String
    var winner : String
    var status : String
    var missilesLaunched : Int
}

class GameStatsViewController: UIViewController {
    
    var gameId : String = ""
    var gameStats : GameStats?
    
    var gameStatsView: GameStatsView {
        return view as! GameStatsView
    }
    
    override func loadView()  {
        view = GameStatsView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getGameStats()
        gameStatsView.gameName.text = gameStats?.name
        gameStatsView.idLabel.text = gameStats?.id
        gameStatsView.player1.text = gameStats?.player1
        gameStatsView.player2.text = gameStats?.player2
        gameStatsView.winner.text = gameStats?.winner
        gameStatsView.status.text = gameStats?.status
        gameStatsView.missles.text = "\(String(describing: gameStats?.missilesLaunched))"
        gameStatsView.reloadData()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    func getGameStats() {
        let webURL = URL(string: "http://174.23.159.139:2142/api/lobby/\(gameId)")!
        let task = URLSession.shared.dataTask(with: webURL) { [weak self] (data, response, error) in
            guard error == nil else {
                print("URL dataTask failed: \(error!)")
                return
            }
            guard let data = data,
                let _ = String(bytes: data, encoding: .utf8)
                else {
                    fatalError("no data to work with")
            }
            self?.gameStats = try! JSONDecoder().decode(GameStats.self, from: data)
        }
        task.resume()
    }
}
