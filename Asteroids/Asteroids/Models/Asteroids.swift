//
//  Asteroids.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/4/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import Foundation
import UIKit

struct Ship {
    var accleration : (x : CGFloat, y : CGFloat)
    var velocity : (x : CGFloat, y : CGFloat)
    var currPos : (x : CGFloat, y : CGFloat)
    var currAngle : CGFloat
}

class Asteriods {
    
    var ship : Ship
    var frame : CGRect
    var gameLoop : Timer
    var oldTime : Date
    var thruster : Bool
    
    init() {
        frame = CGRect()
        gameLoop = Timer()
        oldTime = Date()
        thruster = false
        ship = Ship(accleration: (x: 0.0, y: 0.0), velocity: (x: 0.0, y: 0.0), currPos : (x: 0.0, y: 0.0), currAngle: 0.0)
        gameLoop = Timer.scheduledTimer(withTimeInterval: 1 / 60, repeats: true, block: { gameLoop in
            self.updateGameState()
        })
    }
    
    func updateGameState() {
        let currDate : Date = Date()
        let elapsed : TimeInterval = oldTime.timeIntervalSince(currDate)
        print(elapsed)
        oldTime = currDate
        self.gameLoop(elapsedTime : elapsed)
    }
    
    func gameLoop(elapsedTime : TimeInterval) {
        if thruster {
            ship.accleration = (x: cos(ship.currAngle) * 20.0, y: sin(ship.currAngle) * 20.0)
        }
        else {
            ship.accleration = (x: 0.0, y: 0.0)
        }
        ship.velocity.x += ship.accleration.x * CGFloat(elapsedTime)
        ship.velocity.y += ship.accleration.y * CGFloat(elapsedTime)
        ship.currPos.x += ship.velocity.x * CGFloat(elapsedTime)
        ship.currPos.y += ship.velocity.y * CGFloat(elapsedTime)
    }
    
    func updateFrame(newFrame : CGRect) {
        frame = newFrame
        ship.currPos.x = frame.midX
        ship.currPos.y = frame.midY
    }
    
    func updateThruster(thrusterOn : Bool) {
        thruster = thrusterOn
    }
}
