//
//  HighScoreViewController.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/6/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class HighScoreViewController : UIViewController, HighScoreViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var highScores : [HighScore] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    var highScoreView : HighScoreView {
        return view as! HighScoreView
    }
    
    override func loadView() {
        view = HighScoreView()
    }
    
    override func viewDidLoad() {
        highScoreView.delegate = self
    }
    
    func goBackHome(_ highScoreView: HighScoreView) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HighScoreViewTableCell.self)) as? HighScoreViewTableCell else { fatalError("Could not dequeue cell type: \(HighScoreViewTableCell.self)")}
        _ = cell.increment
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = highScores[indexPath.row].playerName
        cell.detailTextLabel?.text = highScores[indexPath.row].playerScore
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //probably not needed?
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
