//
//  HomeViewController.swift
//  Project3
//
//  Created by Brandon Ward on 3/3/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeViewDelegate {
    func homeView(_ homeView: HomeView) {
        // Todo determine winner
    }
    
    var homeView: HomeView {
        return view as! HomeView
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.delegate = self
        homeView.homeTableView.delegate = self
        homeView.homeTableView.dataSource = self
        homeView.newGameButton.addTarget(self, action: #selector(newGame), for: UIControl.Event.touchUpInside)
    }
    
    @objc func newGame() {
        let newGameViewController = GameViewController()
        present(newGameViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeViewTableCell.self)) as? HomeViewTableCell else { fatalError("Could not dequeue cell type: \(HomeViewTableCell.self)")}
        _ = cell.increment
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .lightGray
    }
}
