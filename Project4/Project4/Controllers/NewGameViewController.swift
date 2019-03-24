//
//  NewGameController.swift
//  Project4
//
//  Created by Brandon Ward on 3/22/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController, UITextFieldDelegate {
    
    var newGameView: NewGameView {
        return view as! NewGameView
    }
    
    override func loadView() {
        view = NewGameView()
    }
    
    override func viewDidLoad() {
        newGameView.backLabel.addTarget(self, action: #selector(goHome), for: UIControl.Event.touchUpInside)
        newGameView.createGame.addTarget(self, action: #selector(createGame), for: UIControl.Event.touchUpInside)
        newGameView.playerNameField.delegate = self
    }
    
    @objc func goHome(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func createGame() {
        print(newGameView.playerNameField.text!)
        let webURL = URL(string: "http://174.23.159.139:2142/api/lobby")!
        
        var postRequest = URLRequest(url: webURL)
        postRequest.httpMethod = "POST"
        let dataString: [String: Any] = ["gameName": "Brandon's Game 3", "playerName": newGameView.playerNameField.text!]
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
                    fatalError("no data to work with")
            }
            print(dataString)
            
        }
        task.resume()
        newGameView.playerNameField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
