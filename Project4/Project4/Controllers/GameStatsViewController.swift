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
    var gameStats : GameStats = GameStats(id: "", name: "", player1: "", player2: "", winner: "", status: "", missilesLaunched: 0)
    
    var gameStatsView: GameStatsView {
        return view as! GameStatsView
    }
    
    override func loadView()  {
        view = GameStatsView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getGameStats()
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
                    print("No data to work with.")
                    return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode)
                else {
                    print("Network Error")
                    return
            }
            self?.gameStats = try! JSONDecoder().decode(GameStats.self, from: data)
            DispatchQueue.main.async { [weak self] in
                self?.updateLabels()
            }
        }
        task.resume()
    }
    
    func updateLabels() {
        gameStatsView.gameName.text = "Game Name: \(gameStats.name)"
        gameStatsView.idLabel.text = "Game Id: \(gameStats.id)"
        gameStatsView.player1.text = "Player 1: \(gameStats.player1)"
        gameStatsView.player2.text = "Player 2: \(gameStats.player2)"
        gameStatsView.winner.text = "Winner: \(gameStats.winner)"
        gameStatsView.status.text = "Status: \(gameStats.status)"
        gameStatsView.missles.text = "Missiles Launched: \(String(gameStats.missilesLaunched))"
        gameStatsView.reloadData()
    }
}
