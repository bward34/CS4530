//
//  SwitchView.swift
//  Project3
//
//  Created by Brandon Ward on 3/2/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class SwitchView: UIView {
    
    var messageLabel: UILabel = UILabel()
    var playerLabel: UILabel = UILabel()
    var hitMissLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func draw(_ rect: CGRect) {
        
        hitMissLabel.frame = CGRect(x: 0.0, y: bounds.midY * 0.5, width: self.frame.width, height: 55.0)
        hitMissLabel.textAlignment = NSTextAlignment.center
        hitMissLabel.font = UIFont(name: "HelveticaNeue", size: 55)
        hitMissLabel.textColor = .white
        hitMissLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(hitMissLabel)
        
        playerLabel.frame = CGRect(x: 0.0, y: bounds.midY, width: self.frame.width, height: 35.0)
        playerLabel.textAlignment = NSTextAlignment.center
        playerLabel.font = UIFont(name: "HelveticaNeue", size: 35)
        playerLabel.textColor = .white
        playerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(playerLabel)
        
        messageLabel.frame = CGRect(x: 0.0, y: bounds.midY * 1.3, width: self.frame.width, height: 40.0)
        messageLabel.textAlignment = NSTextAlignment.center
        messageLabel.text = "Touch to continue!"
        messageLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        messageLabel.textColor = .white
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(messageLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
