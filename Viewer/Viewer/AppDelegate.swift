//
//  AppDelegate.swift
//  Viewer
//
//  Created by Brandon Ward on 1/14/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        
        let view: UIView = UIView()
        view.frame = CGRect(x: 30.0, y: 70.0, width: 100.0, height: 100.0)
        view.backgroundColor = UIColor.green
        window?.rootViewController?.view.addSubview(view)
        
        let subview: UIView = UIView();
        subview.frame = CGRect(x: 5.0, y: 10.0, width: 30.0, height: 30.0)
        subview.backgroundColor = UIColor.blue
        view.addSubview(subview)
        
        let toggle: UISwitch = UISwitch()
        toggle.frame = CGRect(x: 30.0, y: 50.0, width: 200.0, height: 50.0)
        window?.rootViewController?.view.addSubview(toggle)
        
        return true
    }
}
