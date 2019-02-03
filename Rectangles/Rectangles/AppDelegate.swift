//
//  AppDelegate.swift
//  Rectangles
//
//  Created by Brandon Ward on 1/30/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        
        let mainView : UIView = window!.rootViewController!.view
        window?.rootViewController?.view.backgroundColor = .lightGray
        
        let redView : UIView = UIView()
        redView.backgroundColor = .red
        redView.translatesAutoresizingMaskIntoConstraints = false //dont forget this
        mainView.addSubview(redView)
        
        let blueView : UIView = UIView()
        blueView.backgroundColor = .blue
        blueView.translatesAutoresizingMaskIntoConstraints = false //dont forget this
        mainView.addSubview(blueView)
        
        let greenView : UIView = UIView()
        greenView.backgroundColor = .green
        greenView.translatesAutoresizingMaskIntoConstraints = false //dont forget this
        mainView.addSubview(greenView)
        
        let views : [String : Any] = ["red" : redView, "green" : greenView, "blue" : blueView]
        mainView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[red]-12-|", options: [], metrics: nil, views: views))
        mainView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[red]-12-[green]-12-|", options: [], metrics: nil, views: views))
        mainView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[green]-12-|", options: [], metrics: nil, views: views))
        mainView.addConstraint(NSLayoutConstraint(item: redView, attribute: .width, relatedBy: .equal, toItem: greenView, attribute: .width, multiplier: 1.0, constant: 0.0))

        
        
        return true
    }
}

