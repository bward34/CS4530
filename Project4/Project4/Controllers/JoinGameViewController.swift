//
//  JoinGameViewController.swift
//  Project4
//
//  Created by Brandon Ward on 3/26/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import Foundation

import UIKit

class JoinGameViewController: UIViewController, JoinGameViewDelegate, UITextFieldDelegate {
 
    var guidList: [String : String] = [:]
    var gameId: String = ""
    
    deinit {
        print("")
    }
    
    var joinGameView: JoinGameView {
        return view as! JoinGameView
    }
    
    override func loadView() {
        view = JoinGameView()
    }
    
    override func viewDidLoad() {
        joinGameView.playerNameField.delegate = self
        joinGameView.delegate = self
    }
    
    func joinGameView(_ joinGameView: JoinGameView) {
        dismiss(animated: true, completion: nil)
    }
    
    func joinGameView(joinGame joinGameView: JoinGameView) {
        let webURL = URL(string: "http://174.23.151.160:2142/api/lobby/\(gameId)")!
        
        var postRequest = URLRequest(url: webURL)
        postRequest.httpMethod = "PUT"
        let dataString: [String: Any] = ["playerName": joinGameView.playerNameField.text!, "id" : gameId]
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
            if let guidData = try! JSONSerialization.jsonObject(with: data, options: []) as? [String : String] {
                DispatchQueue.main.async { [weak self] in
                    self?.guidList.updateValue(guidData["playerId"]!, forKey: (self?.gameId)!)
                    self?.saveGuids()
                    self?.joinGameView.playerNameField.endEditing(true)
                    let selectedGameController = GameViewController()
                    selectedGameController.gameId = (self?.gameId)!
                    selectedGameController.playerId = guidData["playerId"]!
                    selectedGameController.winner = "IN_PROGRESS"
                    self?.present(selectedGameController, animated: true, completion: nil)
                    
                }
            }
        }
        task.resume()
    }
    
    func saveGuids() {
        let documentsDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        do {
            guard let jsonData = try? JSONEncoder().encode(guidList) else {
                fatalError("Error when encoding")
            }
            guard (try? jsonData.write(to: documentsDirectory.appendingPathComponent(Constants.gamesList))) != nil else {
                fatalError("Error when writing")
            }
        }
    }
}
