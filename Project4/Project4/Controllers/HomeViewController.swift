//
//  HomeViewController.swift
//  Project3 - Project4
//
//  Created by Brandon Ward on 3/3/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeViewDelegate {
    
    var gamesList : [Game] = []
    var lobbyGames : [LobbyGame] = []
    var guidList : [String: String] = [:]
    
    func homeView(_ homeView: HomeView) {
    }
    
    var homeView: HomeView {
        return view as! HomeView
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        loadGames()
        encodDecodeGuids()
        super.viewDidLoad()
        homeView.delegate = self
        homeView.homeTableView.delegate = self
        homeView.homeTableView.dataSource = self
        homeView.newGameButton.addTarget(self, action: #selector(newGame), for: UIControl.Event.touchUpInside)
        homeView.homeTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        encodDecodeGuids()
        loadGames()
    }
    
    @objc func newGame() {
        let newGameViewController = NewGameViewController()
        newGameViewController.guidList = guidList
        present(newGameViewController, animated: true, completion: nil)
    }
    
    func loadGames() {
        let webURL = URL(string: "http://174.23.159.139:2142/api/lobby")!
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
            self?.lobbyGames = try! JSONDecoder().decode([LobbyGame].self, from: data)
            DispatchQueue.main.async { [weak self] in
                self?.homeView.homeTableView.reloadData()
            }
        }
        task.resume()
    }
    
    func encodDecodeGuids() {
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
        if guidList[gameSelected.id] != nil {
            let selectedGameController = GameViewController()
            selectedGameController.gameId = gameSelected.id
            selectedGameController.playerId = guidList[gameSelected.id]!
            selectedGameController.status = gameSelected.status
            present(selectedGameController, animated: true, completion: nil)
        }
    }
}
