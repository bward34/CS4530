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

struct Asteroid {
    var accleration : (x : CGFloat, y : CGFloat)
    var velocity : (x : CGFloat, y : CGFloat)
    var currPos : (x : CGFloat, y : CGFloat)
    var currAngle : CGFloat
    var size : AsteriodSize
}

enum AsteriodSize {
    case Large
    case Medium
    case Small
}

class Asteriods {
    
    var ship : Ship
    var frame : CGRect
    var gameLoop : Timer
    var oldTime : Date
    var thruster : Bool
    var asteroids : [Asteroid]
    
    init() {
        frame = CGRect()
        gameLoop = Timer()
        oldTime = Date()
        asteroids = [Asteroid(accleration: (x: 0.0, y: 0.0), velocity: (x: 0.0, y: 0.0), currPos: (x: 0.0, y: 0.0), currAngle: 34.0, size: AsteriodSize.Small),
        Asteroid(accleration: (x: 0.0, y: 0.0), velocity: (x: 0.0, y: 0.0), currPos: (x: 0.0, y: 0.0), currAngle: 10.0, size: AsteriodSize.Medium),
        Asteroid(accleration: (x: 0.0, y: 0.0), velocity: (x: 0.0, y: 0.0), currPos: (x: 0.0, y: 0.0), currAngle: 29.0, size: AsteriodSize.Large)]
        thruster = false
        ship = Ship(accleration: (x: 0.0, y: 0.0), velocity: (x: 0.0, y: 0.0), currPos : (x: 0.0, y: 0.0), currAngle: 0.0)
        gameLoop = Timer.scheduledTimer(withTimeInterval: 1 / 60, repeats: true, block: { gameLoop in
            self.updateGameState()
        })
    }
    
    func updateGameState() {
        let currDate : Date = Date()
        let elapsed : TimeInterval = oldTime.timeIntervalSince(currDate)
        //print(elapsed)
        oldTime = currDate
        self.gameLoop(elapsedTime : elapsed)
        self.positionAsteroids(elapsedTime: elapsed)
    }
    
    func gameLoop(elapsedTime : TimeInterval) {
        
        if thruster {
            ship.accleration = (x: sin(ship.currAngle) * 35.0, y: -cos(ship.currAngle) * 35.0)
            ship.velocity.x += ship.accleration.x * CGFloat(elapsedTime)
            ship.velocity.y += ship.accleration.y * CGFloat(elapsedTime)
        }
        else {
            ship.accleration = (x: -ship.velocity.x * 0.3, y: -ship.velocity.y * 0.3)
            ship.velocity.x -= ship.accleration.x * CGFloat(elapsedTime)
            ship.velocity.y -= ship.accleration.y * CGFloat(elapsedTime)
        }

        ship.currPos.x += ship.velocity.x * CGFloat(elapsedTime)
        ship.currPos.y += ship.velocity.y * CGFloat(elapsedTime)
    }
    
    func positionAsteroids(elapsedTime : TimeInterval) {
        for var asteroid in asteroids {
            asteroid.accleration = (x: sin(asteroid.currAngle) * 35.0, y: -cos(asteroid.currAngle) * 35.0)
            asteroid.velocity.x += asteroid.accleration.x * CGFloat(elapsedTime)
            asteroid.velocity.y += asteroid.accleration.y * CGFloat(elapsedTime)
            asteroid.currPos.x += asteroid.velocity.x * CGFloat(elapsedTime)
            asteroid.currPos.y += asteroid.velocity.y * CGFloat(elapsedTime)
        }
    }
    
    func updateFrame(newFrame : CGRect) {
        frame = newFrame
        ship.currPos.x = frame.midX
        ship.currPos.y = frame.midY
    }
    
    func AsteroidStartPos() {
        for var asteroid in asteroids {
            asteroid.currPos.x = frame.midX
            asteroid.currPos.y = frame.midY
        }
    }
    
    func updateThruster(thrusterOn : Bool) {
        thruster = thrusterOn
    }
}
