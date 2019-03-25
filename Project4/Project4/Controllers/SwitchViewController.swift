//
//  SwitchViewController.swift
//  Project3 - Project4
//
//  Created by Brandon Ward on 3/2/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class SwitchViewController: UIViewController {
    
    var hitMiss : String = ""
    
    var switchView: SwitchView {
        return view as! SwitchView
    }
    
    override func loadView()  {
        view = SwitchView()
    }
    
    override func viewDidLoad() {
        if hitMiss == "SUNK!" {
            switchView.hitMissLabel.text = hitMiss
            switchView.backgroundColor = .blue
        }
        else if hitMiss == "HIT!" {
            switchView.hitMissLabel.text = hitMiss
            switchView.backgroundColor = .green
        }
        else {
            switchView.hitMissLabel.text = hitMiss
            switchView.backgroundColor = .red
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}
