//
//  HomeViewController.swift
//  Project3 - Project4
//
//  Created by Brandon Ward on 3/3/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeViewDelegate {
    
    var filteredGames : [LobbyGame] = []
    var myGames : [LobbyGame] = []
    var lobbyGames : [LobbyGame] = []
    var guidList : [String: String] = [:]
    var filter : String = ""
    
    func homeView(_ homeView: HomeView) {
    }
    
    var homeView: HomeView {
        return view as! HomeView
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        decodeGuids()
        super.viewDidLoad()
        homeView.delegate = self
        homeView.homeTableView.delegate = self
        homeView.homeTableView.dataSource = self
        homeView.newGameButton.addTarget(self, action: #selector(newGame), for: UIControl.Event.touchUpInside)
        homeView.gameFilter.addTarget(self, action: #selector(filterGames), for: UIControl.Event.valueChanged)
        homeView.homeTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homeView.gameFilter.selectedSegmentIndex = 0
        decodeGuids()
        //loadGames(myGame: false, filter: "WAITING")
     //   loadMyGames(myGame: true)
        filterGames()
        
    }
    
    @objc func newGame() {
        let newGameViewController = NewGameViewController()
        newGameViewController.guidList = guidList
        present(newGameViewController, animated: true, completion: nil)
    }
    
    @objc func filterGames() {
        let filterIndex : Int = homeView.gameFilter.selectedSegmentIndex
        if filterIndex == 0 {
            loadGames(myGame: false, filter: "WAITING")
        }
        else if filterIndex == 1 {
            loadGames(myGame: false, filter: "PLAYING")
        }
        else if filterIndex == 2 {
            loadGames(myGame: false, filter: "DONE")
        }
        else {
            loadMyGames(myGame: true)
        }
    }
    
    func loadGames(myGame: Bool, filter: String) {
        let webURL = URL(string: "http://174.23.159.139:2142/api/lobby?status=\(filter)")!
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
            let getIds = try! JSONDecoder().decode([[String : String]].self, from: data)
            DispatchQueue.main.async { [weak self] in
                self?.lobbyGames = []
                if getIds.count == 0 {
                    self?.homeView.homeTableView.reloadData()
                    return
                }
                for(guid) in getIds {
                    self?.getGameDetail(guid: guid["id"]!, myGames: myGame)
                }
            }
        }
        task.resume()
    }
    
    func loadMyGames(myGame: Bool) {
        let webURL = URL(string: "http://174.23.159.139:2142/api/lobby")!
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
            let myGames = try! JSONDecoder().decode([[String : String ]].self, from: data)
            DispatchQueue.main.async { [weak self] in
                self?.lobbyGames = []
                for (lobbyGame) in myGames {
                    if self?.guidList[lobbyGame["id"]!] != nil {
                        self?.getGameDetail(guid: lobbyGame["id"]!, myGames: myGame)
                    }
                }
            }
        }
        task.resume()
    }
    
    func getGameDetail(guid : String, myGames: Bool) {
        let webURL = URL(string: "http://174.23.159.139:2142/api/lobby/\(guid)")!
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
            let game = try! JSONDecoder().decode(LobbyGame.self, from: data)
            DispatchQueue.main.async { [weak self] in
                //if myGames {
                 //   self?.myGames.append(game)
                //}
                //else {
                    self?.lobbyGames.append(game)
                    self?.homeView.homeTableView.reloadData()
                //}
            }
        }
        task.resume()
    }
    
    func decodeGuids() {
        if !UserDefaults.standard.bool(forKey: "hasLoggedIn") {
            UserDefaults.standard.set(true, forKey: "hasLoggedIn")
            let documentsDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            do {
                guard let jsonData = try? JSONEncoder().encode(guidList) else {
                    throw Game.Error.encoding
                }
                guard (try? jsonData.write(to: documentsDirectory.appendingPathComponent(Constants.gamesList))) != nil else {
                    throw Game.Error.writing
                }
            } catch let error where error is Game.Error {
                print(error)
            } catch {
                print(error)
            }
        }
        else {
            let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let jsonData = try! Data(contentsOf: documentDirectory.appendingPathComponent(Constants.gamesList))
            guidList = try! JSONDecoder().decode([String : String].self, from: jsonData)
        }
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
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let gameSelected: LobbyGame = lobbyGames[indexPath.row]
        if guidList[gameSelected.id] != nil && gameSelected.status != "DONE" {
            let selectedGameController = GameViewController()
            selectedGameController.gameId = gameSelected.id
            selectedGameController.playerId = guidList[gameSelected.id]!
            present(selectedGameController, animated: true, completion: nil)
        }
        else if gameSelected.status == "WAITING" {
            let joinGameContoller = JoinGameViewController()
            joinGameContoller.guidList = guidList
            joinGameContoller.gameId = gameSelected.id
            present(joinGameContoller, animated: true, completion: nil)
        }
        else {
            let gameStatsController = GameStatsViewController()
            gameStatsController.gameId = gameSelected.id
            present(gameStatsController, animated: true, completion: nil)
        }
    }
}
