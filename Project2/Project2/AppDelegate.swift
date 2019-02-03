//
//  AppDelegate.swift
//  Project2
//
//  Created by Brandon Ward on 2/2/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        
        let mainView : UIView = window!.rootViewController!.view
        window?.rootViewController?.view.backgroundColor = .lightGray
        
        let clockView: ClockView = ClockView()
        clockView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(clockView)
        
        let views : [String : Any] = ["clock" : clockView]
        
        mainView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[clock]-12-|", options: [], metrics: nil, views: views))
        mainView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[clock]-12-|", options: [], metrics: nil, views: views))
        return true
    }
}

