//
//  HomeViewController.swift
//  Project3
//
//  Created by Brandon Ward on 3/3/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeViewDelegate {
    
    var gamesList : [Game] = []
    var lobbyGames : [LobbyGame] = []
    func homeView(_ homeView: HomeView) {
    }
    
    var homeView: HomeView {
        return view as! HomeView
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        
        let webURL = URL(string: "http://174.23.159.139:2142/api/lobby")!
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
           self?.lobbyGames = try! JSONDecoder().decode([LobbyGame].self, from: data)
            DispatchQueue.main.async {
                self?.homeView.homeTableView.reloadData()
            }
        }.resume()
        
        if !UserDefaults.standard.bool(forKey: "hasLoggedIn") {
            UserDefaults.standard.set(true, forKey: "hasLoggedIn")
            let documentsDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            do {
                try gamesList.save(to: documentsDirectory.appendingPathComponent(Constants.gamesList))
            } catch let error where error is Game.Error {
                  print(error)
            } catch {
                print(error)
            }
        }
        else {
            let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let jsonData = try! Data(contentsOf: documentDirectory.appendingPathComponent(Constants.gamesList))
            gamesList = try! JSONDecoder().decode([Game].self, from: jsonData)
        }
        super.viewDidLoad()
        homeView.delegate = self
        homeView.homeTableView.delegate = self
        homeView.homeTableView.dataSource = self
        homeView.newGameButton.addTarget(self, action: #selector(newGame), for: UIControl.Event.touchUpInside)
        homeView.homeTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {  
        homeView.homeTableView.reloadData()
    }
    
    @objc func newGame() {
        let newGameViewController = GameViewController()
        gamesList.insert(newGameViewController.game, at: 0)
        newGameViewController.gameIndex = 0
        newGameViewController.gamesList = gamesList
        present(newGameViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lobbyGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeViewTableCell.self)) as? HomeViewTableCell else { fatalError("Could not dequeue cell type: \(HomeViewTableCell.self)")}
        _ = cell.increment
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = lobbyGames[indexPath.row].name
        cell.detailTextLabel?.text = lobbyGames[indexPath.row].status
//        var gameProgress : String = ""
//        if gamesList[indexPath.row].winner != Game.Token.none {
//            let winner : String = gamesList[indexPath.row].winner == Game.Token.player1 ? "Player 1" : "Player 2"
//            gameProgress = "Complete - Winner: \(winner)"
//            cell.textLabel?.textColor = .green
//        }
//        else {
//            let currentPlayer : String = gamesList[indexPath.row].currentPlayer == Game.Token.player1 ? "P1" : "P2"
//            gameProgress = "In Progress - Current Player: \(currentPlayer)"
//            cell.textLabel?.textColor = .red
//
//        }
//        cell.backgroundColor = .white
//        cell.detailTextLabel?.text = "P1 Ships: \(getShipsNotSunk(shipsSunk: gamesList[indexPath.row].shipsSunk[Game.Token.player1]!)) P2 Ships: \(getShipsNotSunk(shipsSunk: gamesList[indexPath.row].shipsSunk[Game.Token.player2]!))"
//        cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue", size: 10)
//        cell.textLabel?.font = UIFont(name: "HelveticaNeue", size: 10)
//        cell.textLabel?.text = gameProgress
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newGameController = GameViewController()
        newGameController.game = gamesList[indexPath.row]
        newGameController.gameIndex = indexPath.row
        newGameController.gamesList = gamesList
        present(newGameController, animated: true, completion: nil)
    }
    
    func getShipsNotSunk(shipsSunk : [Game.Token : Bool]) -> Int {
        var count = 0
        for(_, sunk) in shipsSunk {
            if !sunk {
                count += 1
            }
        }
        return count
    }
    
    
}
