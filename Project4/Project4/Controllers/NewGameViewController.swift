//
//  NewGameController.swift
//  Project4
//
//  Created by Brandon Ward on 3/22/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController, NewGameViewDelegate, UITextFieldDelegate {
    
    var guidList: [String : String] = [:]
    
    var newGameView: NewGameView {
        return view as! NewGameView
    }
    
    override func loadView() {
        view = NewGameView()
    }
    
    override func viewDidLoad() {
        newGameView.delegate = self
        newGameView.playerNameField.delegate = self
    }
    
    func newGameView(_ newGameView: NewGameView) {
        dismiss(animated: true, completion: nil)
    }
    
    func newGameView(createGame newGameView: NewGameView) {
        let webURL = URL(string: "http://174.23.151.160:2142/api/lobby")!
        
        var postRequest = URLRequest(url: webURL)
        postRequest.httpMethod = "POST"
        let dataString: [String: Any] = ["gameName": newGameView.gameNameField.text!, "playerName": newGameView.playerNameField.text!]
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
                fatalError("UR failed: \(error!)")
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
                    self?.guidList.updateValue(guidData["playerId"]!, forKey: guidData["gameId"]!)
                    self?.saveGuids()
                    self?.newGameView.playerNameField.endEditing(true)
                    let selectedGameController = GameViewController()
                    selectedGameController.gameId = guidData["gameId"]!
                    selectedGameController.playerId = guidData["playerId"]!
                    selectedGameController.winner = "WAITING"
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
