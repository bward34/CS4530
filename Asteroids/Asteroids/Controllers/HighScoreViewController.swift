//
//  HighScoreViewController.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/6/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class HighScoreViewController : UIViewController, HighScoreViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var highScores : [HighScore]?
    
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
        highScoreView.highScoreTableView.dataSource = self
        highScoreView.highScoreTableView.delegate = self
        highScoreView.highScoreTableView.backgroundColor = .clear
        highScoreView.highScoreTableView.isOpaque = false
        highScoreView.highScoreTableView.separatorColor = UIColor(hue: 0.3194, saturation: 1, brightness: 1, alpha: 1.0)
    }
    
    func goBackHome(_ highScoreView: HighScoreView) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScores!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HighScoreViewTableCell.self)) as? HighScoreViewTableCell else { fatalError("Could not dequeue cell type: \(HighScoreViewTableCell.self)")}
        _ = cell.increment
        cell.layer.backgroundColor = UIColor.clear.cgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = highScores?[indexPath.row].playerName
        cell.textLabel?.font = UIFont(name: "Future-Earth", size: 12)
        cell.textLabel?.textColor = UIColor(hue: 0.3194, saturation: 1, brightness: 1, alpha: 1.0)
        cell.detailTextLabel?.text = highScores?[indexPath.row].playerScore
        cell.detailTextLabel?.font = UIFont(name: "Future-Earth", size: 12)
        cell.detailTextLabel?.textColor = UIColor(hue: 0.3194, saturation: 1, brightness: 1, alpha: 1.0)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
