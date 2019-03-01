//
//  ViewController.swift
//  Complications
//
//  Created by Brandon Ward on 2/27/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var valueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        valueSlider.value = 0.8
    }


}

