//
//  main.swift
//  ConcurencyStuff
//
//  Created by Brandon Ward on 2/11/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import Foundation

class Foo{
    typealias CallbackFunction = () -> Void
    
    var callback: CallbackFunction
    
    init(callback: @escaping CallbackFunction) {
        self.callback = callback
    }
}

let foo2: Foo
do {
    let foo = Foo(callback: {
        print("Hell0 world")
    })
    
    foo2 = Foo { [foo] in
        print("hello from foo 2")
        foo.callback()
    }
}


//DispatchQueue.global().async {
//    foo2.callback()
//}
//sleep(2)

//same as java interface
protocol  BarDelegate : AnyObject {
    func doStuff()
}

class Bar {
    weak var delgate: BarDelegate?
    func runAysncTask(printing string : String, onCompletion: (() -> Void)? = nil) {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3.0) { [weak self] in
        self?.delgate?.doStuff()
        onCompletion?()
        }
    }
}

class Baz : BarDelegate {
    var count : Int = 0
    
    func doStuff() {
        count += 1
    }
}

let bar = Bar()
let baz = Baz()
bar.delgate = baz

bar.runAysncTask(printing: "Hello") {
    print("Count : \(baz.count)")
}
