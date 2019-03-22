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

        hitMissLabel.textAlignment = NSTextAlignment.center
        hitMissLabel.font = UIFont(name: "HelveticaNeue", size: 55)
        hitMissLabel.textColor = .white
        hitMissLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(hitMissLabel)

        playerLabel.textAlignment = NSTextAlignment.center
        playerLabel.font = UIFont(name: "HelveticaNeue", size: 25)
        playerLabel.textColor = .white
        playerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(playerLabel)

        messageLabel.textAlignment = NSTextAlignment.center
        messageLabel.text = "Touch to continue!"
        messageLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        messageLabel.textColor = .white
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(messageLabel)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[hitMissLabel]-|", options: [], metrics: nil, views: ["hitMissLabel": hitMissLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[playerLabel]-|", options: [], metrics: nil, views: ["playerLabel": playerLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[messageLabel]-|", options: [], metrics: nil, views: ["messageLabel": messageLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[hitMissLabel]-[playerLabel]-[messageLabel]-|", options: [], metrics: nil, views: ["hitMissLabel" : hitMissLabel,"playerLabel": playerLabel, "messageLabel" : messageLabel]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
