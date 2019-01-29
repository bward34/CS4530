//
//  main.swift
//  Mathy
//
//  Created by Brandon Ward on 1/9/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import Foundation

struct Vector {
    var x: Double
    var y: Double
    //or use init here
}

let v: Vector = Vector(x: <#T##Double#>, y: <#T##Double#>)
let x: Int? = 78

//adding ! called forced unwrapped

guard let unwrappedX = x else {
    exit(0)
}

if let x = x {
    print("x: \(x)")
}

