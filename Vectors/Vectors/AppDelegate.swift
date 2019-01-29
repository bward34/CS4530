//
//  AppDelegate.swift
//  Vectors
//
//  Created by Brandon Ward on 1/16/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //UISlider(s)
    var vectorAxSlider : UISlider?
    var vectorAySlider : UISlider?
    var vectorAzSlider : UISlider?
    var vectorBxSlider : UISlider?
    var vectorBySlider : UISlider?
    var vectorBzSlider : UISlider?
    
    //Title
    var titleLable: UILabel?
    
    //X,Y,Z label
    var AxLabel : UILabel?
    var AxValue : UILabel?
    var AyLabel : UILabel?
    var AyValue : UILabel?
    var AzLabel : UILabel?
    var AzValue : UILabel?
    var BxLabel : UILabel?
    var BxValue : UILabel?
    var ByLabel : UILabel?
    var ByValue : UILabel?
    var BzLabel : UILabel?
    var BzValue : UILabel?
    
    //Calculations labels
    var AplusB : UILabel?
    var AplusBValue: UILabel?
    var AdotB : UILabel?
    var AdotBValue : UILabel?
    var AcrossB: UILabel?
    var AcrossBValue: UILabel?

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        
        window?.rootViewController?.view.backgroundColor = UIColor.lightGray
        
        //this is okay because we just make the root view controller
        let mainView: UIView = window!.rootViewController!.view
        
        titleLable = UILabel()
        titleLable?.frame = CGRect(x: 90.0, y: 30.0, width: 250.0, height: 40.0)
        titleLable?.text = "Vector Operations"
        mainView.addSubview(titleLable!)
        
        // MARK: Ax labels and sliders.
        AxLabel = UILabel()
        AxLabel?.frame = CGRect(x: 10.0, y: 60.0, width: 25.0, height: 40.0)
        AxLabel?.text = "Ax"
        mainView.addSubview(AxLabel!)
        
        AxValue = UILabel()
        AxValue?.frame = CGRect(x: 270, y: 60.0, width: 45.0, height: 40.0)
        AxValue?.text = "0.00"
        mainView.addSubview(AxValue!)
        
        vectorAxSlider = UISlider()
        vectorAxSlider?.frame = CGRect(x: 30.0, y: 60.0, width: 240.0, height: 40.0)
        vectorAxSlider?.addTarget(self, action: #selector(vectorChanged), for: UIControl.Event.valueChanged)
        mainView.addSubview(vectorAxSlider!)
        
        // MARK: Ay labels and sliders.
        AyLabel = UILabel()
        AyLabel?.frame = CGRect(x: 10.0, y: 110.0, width: 25.0, height: 40.0)
        AyLabel?.text = "Ay"
        mainView.addSubview(AyLabel!)
        
        AyValue = UILabel()
        AyValue?.frame = CGRect(x: 270, y: 110.0, width: 45.0, height: 40.0)
        AyValue?.text = "0.00"
        mainView.addSubview(AyValue!)
        
        vectorAySlider = UISlider()
        vectorAySlider?.frame = CGRect(x: 30.0, y: 110.0, width: 240.0, height: 40.0)
         vectorAySlider?.addTarget(self, action: #selector(vectorChanged), for: UIControl.Event.valueChanged)
        mainView.addSubview(vectorAySlider!)
        
        // MARK: Az labels and sliders.
        AzLabel = UILabel()
        AzLabel?.frame = CGRect(x: 10.0, y: 160.0, width: 25.0, height: 40.0)
        AzLabel?.text = "Az"
        mainView.addSubview(AzLabel!)
        
        AzValue = UILabel()
        AzValue?.frame = CGRect(x: 270, y: 160.0, width: 45.0, height: 40.0)
        AzValue?.text = "0.00"
        mainView.addSubview(AzValue!)
        
        vectorAzSlider = UISlider()
        vectorAzSlider?.frame = CGRect(x: 30.0, y: 160.0, width: 240.0, height: 40.0)
         vectorAzSlider?.addTarget(self, action: #selector(vectorChanged), for: UIControl.Event.valueChanged)
        mainView.addSubview(vectorAzSlider!)
        
        // MARK: Bx labels and sliders.
        BxLabel = UILabel()
        BxLabel?.frame = CGRect(x: 10.0, y: 210.0, width: 25.0, height: 40.0)
        BxLabel?.text = "Bx"
        mainView.addSubview(BxLabel!)
        
        BxValue = UILabel()
        BxValue?.frame = CGRect(x: 270, y: 210.0, width: 45.0, height: 40.0)
        BxValue?.text = "0.00"
        mainView.addSubview(BxValue!)
        
        vectorBxSlider = UISlider()
        vectorBxSlider?.frame = CGRect(x: 30.0, y: 210.0, width: 240.0, height: 40.0)
         vectorBxSlider?.addTarget(self, action: #selector(vectorChanged), for: UIControl.Event.valueChanged)
        mainView.addSubview(vectorBxSlider!)
        
        // MARK: By labels and sliders.
        ByLabel = UILabel()
        ByLabel?.frame = CGRect(x: 10.0, y: 260.0, width: 25.0, height: 40.0)
        ByLabel?.text = "By"
        mainView.addSubview(ByLabel!)
        
        ByValue = UILabel()
        ByValue?.frame = CGRect(x: 270, y: 260.0, width: 45.0, height: 40.0)
        ByValue?.text = "0.00"
        mainView.addSubview(ByValue!)
        
        vectorBySlider = UISlider()
        vectorBySlider?.frame = CGRect(x: 30.0, y: 260.0, width: 240.0, height: 40.0)
        vectorBySlider?.addTarget(self, action: #selector(vectorChanged), for: UIControl.Event.valueChanged)
        mainView.addSubview(vectorBySlider!)
        
        // MARK: Bz labels and sliders.
        BzLabel = UILabel()
        BzLabel?.frame = CGRect(x: 10.0, y: 310.0, width: 25.0, height: 40.0)
        BzLabel?.text = "Bz"
        mainView.addSubview(BzLabel!)
        
        BzValue = UILabel()
        BzValue?.frame = CGRect(x: 270, y: 310.0, width: 45.0, height: 40.0)
        BzValue?.text = "0.00"
        mainView.addSubview(BzValue!)
        
        vectorBzSlider = UISlider()
        vectorBzSlider?.frame = CGRect(x: 30.0, y: 310.0, width: 240.0, height: 40.0)
        vectorBzSlider?.addTarget(self, action: #selector(vectorChanged), for: UIControl.Event.valueChanged)
        mainView.addSubview(vectorBzSlider!)
        
        // MARK: Vector Calculations
        AplusB = UILabel()
        AplusB?.frame = CGRect(x: 50.0, y: 360.0, width: 55.0, height: 40.0)
        AplusB?.text = "A + B:"
        mainView.addSubview(AplusB!)
        
        AplusBValue = UILabel()
        AplusBValue?.frame = CGRect(x: 100.0, y: 360.0, width: 170.0, height: 40.0)
        AplusBValue?.textAlignment = NSTextAlignment.center
        AplusBValue?.text = "(0.00,0.00,0.00)"
        mainView.addSubview(AplusBValue!)
        
        AdotB = UILabel()
        AdotB?.frame = CGRect(x: 56.0, y: 380.0, width: 55.0, height: 40.0)
        AdotB?.text = "A · B:"
        mainView.addSubview(AdotB!)
        
        AdotBValue = UILabel()
        AdotBValue?.frame = CGRect(x: 100.0, y: 380.0, width: 170.0, height: 40.0)
        AdotBValue?.textAlignment = NSTextAlignment.center
        AdotBValue?.text = "0.00"
        mainView.addSubview(AdotBValue!)
        
        AcrossB = UILabel()
        AcrossB?.frame = CGRect(x: 52.0, y: 400.0, width: 130.0, height: 40.0)
        AcrossB?.text = "A x B:"
        mainView.addSubview(AcrossB!)
        
        AcrossBValue = UILabel()
        AcrossBValue?.frame = CGRect(x: 100.0, y: 400.0, width: 170.0, height: 40.0)
        AcrossBValue?.textAlignment = NSTextAlignment.center;
        AcrossBValue?.text = "(0.00,0.00,0.00)"
        mainView.addSubview(AcrossBValue!)
        
        return true
    }
    
    
    @objc func vectorChanged(sender: Any) {
        if let axValue = vectorAxSlider {
            AxValue?.text = "\(String(format: "%.2f" , axValue.value))"
        }
        if let ayValue = vectorAySlider {
            AyValue?.text = "\(String(format: "%.2f" , ayValue.value))"
        }
        if let azValue = vectorAzSlider {
            AzValue?.text = "\(String(format: "%.2f" , azValue.value))"
        }
        if let bxValue = vectorBxSlider {
            BxValue?.text = "\(String(format: "%.2f" , bxValue.value))"
        }
        if let byValue = vectorBySlider {
            ByValue?.text = "\(String(format: "%.2f" , byValue.value))"
        }
        if let bzValue = vectorBzSlider {
            BzValue?.text = "\(String(format: "%.2f" , bzValue.value))"
        }
        
        //Force unwrapped because value will never be nil
        updateAddition(Ax: vectorAxSlider!.value, Ay: vectorAySlider!.value, Az: vectorAzSlider!.value, Bx: vectorBxSlider!.value, By: vectorBySlider!.value, Bz: vectorBzSlider!.value)
        
        updateDotProduct(Ax: vectorAxSlider!.value, Ay: vectorAySlider!.value, Az: vectorAzSlider!.value, Bx: vectorBxSlider!.value, By: vectorBySlider!.value, Bz: vectorBzSlider!.value)
        
        updateCrossProduct(Ax: vectorAxSlider!.value, Ay: vectorAySlider!.value, Az: vectorAzSlider!.value, Bx: vectorBxSlider!.value, By: vectorBySlider!.value, Bz: vectorBzSlider!.value)
    }
    
    func updateAddition(Ax: Float, Ay: Float, Az: Float, Bx: Float, By: Float, Bz: Float) {
        let value1 = Ax + Bx
        let value2 = Ay + By
        let value3 = Az + Bz
        
        AplusBValue?.text = "(\(String(format: "%.2f" , value1)),\(String(format: "%.2f" , value2)),\(String(format: "%.2f" , value3)))"
    }
    
    func updateDotProduct(Ax: Float, Ay: Float, Az: Float, Bx: Float, By: Float, Bz: Float) {
        let value = (Ax * Bx) + (Ay * By) + (Az * Bz)
        AdotBValue?.text = "\(String(format: "%.2f" , value))"
    }
    
    func updateCrossProduct(Ax: Float, Ay: Float, Az: Float, Bx: Float, By: Float, Bz: Float) {
        
        let x = (Ay * Bz) - (Az * By)
        let y = (Az * Bx) - (Ax * Bz)
        let z = (Ax * By) - (Ay * Bx)
        
        AcrossBValue?.text = "(\(String(format: "%.2f" , x)),\(String(format: "%.2f" , y)),\(String(format: "%.2f" , z)))"
        
    }

}

