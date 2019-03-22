//
//  ViewController.swift
//  WebScrapper
//
//  Created by Brandon Ward on 3/4/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let webURL = URL(string: "nytimes.com")!
    var images : [Any] = []
    
    var collectionView : UICollectionView {
        return view as! UICollectionView
    }

    override func loadView() {
        let layout = UICollectionViewFlowLayout()
        view = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

extension ViewController : UICollectionViewDelegate {
    //func collectionViewint
    
}

