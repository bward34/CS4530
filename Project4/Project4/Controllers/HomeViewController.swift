//
//  HomeViewController.swift
//  Project3 - Project4
//
//  Created by Brandon Ward on 3/3/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeViewDelegate {
    
    //Filtered games
    var doneGames : [LobbyGame] = []
    var waitingGames : [LobbyGame] = []
    var playingGames : [LobbyGame] = []
    
    //User games
    var deviceGames : [LobbyGame] = []
    
    //Displayed Games
    var lobbyGames : [LobbyGame] = []
    
    var guidList : [String: String] = [:]
    var gameCount : Int = 0
    
    
    var homeView: HomeView {
        return view as! HomeView
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        loadGames(filter: "WAITING")
        loadMyGames(filter: "MINE")
        homeView.gameFilter.selectedSegmentIndex = 0
        lobbyGames = waitingGames
        decodeGuids()
        super.viewDidLoad()
        homeView.delegate = self
        homeView.homeTableView.delegate = self
        homeView.homeTableView.dataSource = self
        homeView.homeTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        decodeGuids()
        if let index = homeView.homeTableView.indexPathForSelectedRow{
            homeView.homeTableView.deselectRow(at: index, animated: true)
        }
    }
    
    func homeView(_ homeView: HomeView, refreshTable cellIndex: Int) {
        homeView.homeTableView.refreshControl?.endRefreshing()
        let filterIndex : Int = cellIndex
        lobbyGames = []
        if filterIndex == 0 {
            loadGames(filter: "WAITING")
        }
        else if filterIndex == 1 {
            loadGames(filter: "PLAYING")
        }
        else if filterIndex == 2 {
            loadGames(filter: "DONE")
        }
        else {
            loadMyGames(filter: "MINE")
        }
        homeView.homeTableView.reloadData()
    }
    
    func homeView(_ homeView: HomeView, cellIndex: Int) {
        let filterIndex : Int = cellIndex
        lobbyGames = []
        if filterIndex == 0 {
            if waitingGames.count == 0 {
                loadGames(filter: "WAITING")
            }
            else {
                homeView.homeTableView.refreshControl?.endRefreshing()
            }
            lobbyGames = waitingGames
        }
        else if filterIndex == 1 {
            if playingGames.count == 0 {
               loadGames(filter: "PLAYING")
            }
            else {
               homeView.homeTableView.refreshControl?.endRefreshing()
            }
            lobbyGames = playingGames
        }
        else if filterIndex == 2 {
            if doneGames.count == 0 {
              loadGames(filter: "DONE")
            }
            else {
            homeView.homeTableView.refreshControl?.endRefreshing()
            }
            lobbyGames = doneGames
        }
        else {
            homeView.homeTableView.refreshControl?.endRefreshing()
            lobbyGames = deviceGames
        }
        homeView.homeTableView.reloadData()
    }
    
    func homeView(_ homeView: HomeView) {
        let newGameViewController = NewGameViewController()
        newGameViewController.guidList = guidList
        present(newGameViewController, animated: true, completion: nil)
    }
    
    func loadGames(filter: String) {
        homeView.homeTableView.refreshControl?.beginRefreshing()
        let webURL = URL(string: "http://174.23.151.160:2142/api/lobby?status=\(filter)")!
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
                self?.gameCount = getIds.count
                if self?.gameCount == 0 {
                    self?.homeView.homeTableView.refreshControl?.endRefreshing()
                    self?.homeView.homeTableView.reloadData()
                }
            }
                if filter == "WAITING" {
                    self?.waitingGames = []
                }
                else if filter == "PLAYING" {
                    self?.playingGames = []
                }
                else if filter == "DONE" {
                    self?.doneGames = []
                }
                else {
                    self?.deviceGames = []
                }
                for(guid) in getIds {
                    self?.getGameDetail(guid: guid["id"]!, filter: filter)
                }
        }
        homeView.homeTableView.reloadData()
        task.resume()
    }
    
    func loadMyGames(filter: String) {
        homeView.homeTableView.refreshControl?.beginRefreshing()
        let webURL = URL(string: "http://174.23.151.160:2142/api/lobby")!
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
            var myGameCount : Int = 0
            self?.deviceGames = []
            for (lobbyGame) in myGames {
                if self?.guidList[lobbyGame["id"]!] != nil {
                    myGameCount = myGameCount + 1
                    self?.getGameDetail(guid: lobbyGame["id"]!, filter: filter)
                }
            }
            DispatchQueue.main.async { [weak self] in
              self?.gameCount = myGameCount
              if self?.gameCount == 0 {
                 self?.homeView.homeTableView.refreshControl?.endRefreshing()
                 self?.homeView.homeTableView.reloadData()
              }
            }
        }
        homeView.homeTableView.reloadData()
        task.resume()
    }
    
    func getGameDetail(guid : String, filter: String) {
        let webURL = URL(string: "http://174.23.151.160:2142/api/lobby/\(guid)")!
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
            if filter == "WAITING" {
                self?.waitingGames.append(game)
            }
            else if filter == "PLAYING" {
                self?.playingGames.append(game)
            }
            else if filter == "DONE" {
                self?.doneGames.append(game)
            }
            else {
                self?.deviceGames.append(game)
                self?.deviceGames.sort(by: {($0.status, $1.missilesLaunched) > ($1.status, $0.missilesLaunched) })
            }
          DispatchQueue.main.async { [weak self] in
            //Append games
            if self?.homeView.gameFilter.selectedSegmentIndex == 0 && filter == "WAITING" {
                self?.lobbyGames.append(game)
            }
            else if self?.homeView.gameFilter.selectedSegmentIndex == 1 && filter == "PLAYING" {
                self?.lobbyGames.append(game)
            }
            else if self?.homeView.gameFilter.selectedSegmentIndex == 2 && filter == "DONE" {
                self?.lobbyGames.append(game)
            }
            else if self?.homeView.gameFilter.selectedSegmentIndex == 3 && filter == "MINE" {
                self?.lobbyGames.append(game)
                self?.lobbyGames.sort(by: {($0.status, $1.missilesLaunched) > ($1.status, $0.missilesLaunched) })
            }
            if self?.lobbyGames.count == self?.gameCount {
                self?.homeView.homeTableView.refreshControl?.endRefreshing()
            }
            self?.homeView.homeTableView.reloadData()
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
        if lobbyGames.count == 0 {
            tableView.backgroundView = homeView.emptyLabel
            tableView.separatorStyle = .none
            return 0
        }
        tableView.refreshControl?.isUserInteractionEnabled = true
        tableView.backgroundView = .none
        tableView.separatorStyle = .singleLine
        return lobbyGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeViewTableCell.self)) as? HomeViewTableCell else { fatalError("Could not dequeue cell type: \(HomeViewTableCell.self)")}
        _ = cell.increment
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentPlayer : String = lobbyGames[indexPath.row].missilesLaunched % 2 == 0 ? lobbyGames[indexPath.row].player1 : lobbyGames[indexPath.row].player2
        let turnInfo : String = lobbyGames[indexPath.row].winner == "IN_PROGRESS" ? "Current Turn: \(currentPlayer)" : "Winner: \(lobbyGames[indexPath.row].winner)"
        cell.textLabel?.text = "\(lobbyGames[indexPath.row].name) - \(lobbyGames[indexPath.row].status)"
        cell.textLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 15)
        cell.detailTextLabel?.text = "\(turnInfo)\nMissiles Launched: \(lobbyGames[indexPath.row].missilesLaunched)"
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.textColor = .blue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let gameSelected: LobbyGame = lobbyGames[indexPath.row]
        if guidList[gameSelected.id] != nil {
            let selectedGameController = GameViewController()
            selectedGameController.gameId = gameSelected.id
            selectedGameController.winner = gameSelected.winner
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
