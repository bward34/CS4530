//
//  AppDelegate.swift
//  Time
//
//  Created by Brandon Ward on 1/23/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow();
        window?.rootViewController = UIViewController();
        window?.makeKeyAndVisible()
        
        let clockView: ClockView = ClockView();
        clockView.backgroundColor = UIColor.lightGray
        clockView.frame = CGRect(x: 20.0, y: 20.0, width: 200.0, height: 400.0)
        window?.rootViewController?.view.addSubview(clockView)
        return true
    }
}
