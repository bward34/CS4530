//
//  ViewController.swift
//  DataPerisistence
//
//  Created by Brandon Ward on 2/25/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var shoppingLists : [ShoppingList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0 ..< 5 {
            var shoppingList = ShoppingList(storeName: "\(i)", item: [i, i + 2, i + 2].map(String.init))
           // print(shoppingList)
            shoppingLists.append(shoppingList)
        }
        
        //print()
       // print(shoppingLists)
    }


}

