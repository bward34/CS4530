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
    
    let timeZoneLabel : UILabel = UILabel()
    let gmtOffset : UILabel = UILabel()
    let clockView: ClockView = ClockView()
    
    override init() {
      super.init()
        
      timeZoneLabel.text = clockView.getTimeZoneLabel()
        gmtOffset.text = "GMT: \(clockView.getOffSet())"
        
      Timer.scheduledTimer(timeInterval: (1 / 10), target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
    }

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        
        let mainView : UIView = window!.rootViewController!.view
        window?.rootViewController?.view.backgroundColor = UIColor(red: 0.0, green: 0.298, blue: 0.329, alpha: 1.0)
        clockView.translatesAutoresizingMaskIntoConstraints = false
        clockView.backgroundColor = UIColor.clear
        mainView.addSubview(clockView)
        
        timeZoneLabel.frame = CGRect(x: 0.0, y: 30.0, width: mainView.frame.width, height: 20.0)
        timeZoneLabel.textAlignment = NSTextAlignment.center
        timeZoneLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 25)
        timeZoneLabel.textColor = .white
        timeZoneLabel.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(timeZoneLabel)
        
        gmtOffset.frame = CGRect(x: 0.0, y: 80.0, width: mainView.frame.width, height: 20.0)
        gmtOffset.textAlignment = NSTextAlignment.center
        gmtOffset.font = UIFont(name: "HelveticaNeue-UltraLight", size: 15)
        gmtOffset.textColor = .white
        gmtOffset.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(gmtOffset)
        
        let views : [String : Any] = ["clock" : clockView, "tzLabel" : timeZoneLabel, "offset" : gmtOffset]
        
        mainView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[tzLabel][offset][clock(<=\(mainView.frame.width))]-|", options: [], metrics: nil, views: views))
        mainView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tzLabel(<=\(mainView.frame.width))]-|", options: [], metrics: nil, views: views))
        mainView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[offset(<=\(mainView.frame.width))]-|", options: [], metrics: nil, views: views))
        mainView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[clock(<=\(mainView.frame.width))]-|", options: [], metrics: nil, views: views))
        
        return true
    }
    
    @objc func updateLabel() {
        timeZoneLabel.text = clockView.getTimeZoneLabel()
        let offset = clockView.getOffSet()
        gmtOffset.text = offset <= 0 ? "GMT: \(offset)" : "GMT: +\(offset)"
    }
}

