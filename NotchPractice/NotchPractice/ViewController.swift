//
//  ViewController.swift
//  NotchPractice
//
//  Created by Brandon Ward on 3/18/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let safeAreaView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safeAreaView.backgroundColor = .green
        view.addSubview(safeAreaView)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        safeAreaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        safeAreaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        safeAreaView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        safeAreaView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    }


}

