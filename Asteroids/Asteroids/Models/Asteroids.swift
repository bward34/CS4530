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
}

struct Laser {
   var accleration : (x : CGFloat, y : CGFloat)
   var currPos : (x : CGFloat, y : CGFloat)
   var velocity : (x : CGFloat, y : CGFloat)
   var currAngle : CGFloat
   var timeSpawned : Date
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
    var fire : Bool
    var asteroids : [AsteriodSize : [Asteroid]]
    var lasers : [Laser]
    var fireCount : Int
    
    init() {
        fireCount = 0
        frame = CGRect()
        gameLoop = Timer()
        oldTime = Date()
        lasers = []
        asteroids = [AsteriodSize.Large :
                    [Asteroid(accleration: (x: 0.0, y: 0.0), velocity: (x: 0.0, y: 0.0), currPos: (x: 0.0, y: 0.0), currAngle: 0.0),
                     Asteroid(accleration: (x: 0.0, y: 0.0), velocity: (x: 0.0, y: 0.0), currPos: (x: 0.0, y: 0.0), currAngle: 0.0),
                     Asteroid(accleration: (x: 0.0, y: 0.0), velocity: (x: 0.0, y: 0.0), currPos: (x: 0.0, y: 0.0), currAngle: 0.0),
                     Asteroid(accleration: (x: 0.0, y: 0.0), velocity: (x: 0.0, y: 0.0), currPos: (x: 0.0, y: 0.0), currAngle: 0.0)],
                     AsteriodSize.Medium : [],
                     AsteriodSize.Small: []]
        thruster = false
        fire = false
        ship = Ship(accleration: (x: 0.0, y: 0.0), velocity: (x: 0.0, y: 0.0), currPos : (x: 0.0, y: 0.0), currAngle: 0.0)
        gameLoop = Timer.scheduledTimer(withTimeInterval: 1 / 60, repeats: true, block: { gameLoop in
            self.updateGameState()
        })
    }
    
    func updateGameState() {
        let currDate : Date = Date()
        let elapsed : TimeInterval = oldTime.timeIntervalSince(currDate)
        oldTime = currDate
        self.positionShip(elapsedTime : elapsed)
        self.positionAsteroids(elapsedTime: elapsed)
        self.updateLasers()
        self.positionLaserPoints(elapsedTime: elapsed)
        self.fireCount = self.fireCount + 1
    }
    
    func positionShip(elapsedTime : TimeInterval) {
        
        if thruster {
            ship.accleration = (x: sin(ship.currAngle) * 35.0, y: -cos(ship.currAngle) * 35.0)
            ship.velocity.x += ship.accleration.x * CGFloat(elapsedTime)
            ship.velocity.y += ship.accleration.y * CGFloat(elapsedTime)
        }
        else {
            ship.accleration = (x: -ship.velocity.x * 0.5, y: -ship.velocity.y * 0.5)
            ship.velocity.x -= ship.accleration.x * CGFloat(elapsedTime)
            ship.velocity.y -= ship.accleration.y * CGFloat(elapsedTime)
        }

        ship.currPos.x += ship.velocity.x * CGFloat(elapsedTime)
        ship.currPos.y += ship.velocity.y * CGFloat(elapsedTime)
        
        if ship.currPos.x < 0 {
            ship.currPos.x = frame.maxX
        }
        else if ship.currPos.x > frame.maxX {
            ship.currPos.x = 0
        }
        
        if ship.currPos.y < 0 {
            ship.currPos.y = frame.maxY
        }
        else if ship.currPos.y > frame.maxY {
            ship.currPos.y = 0
        }
    }
    
    func positionAsteroids(elapsedTime : TimeInterval) {
        for (key, list) in asteroids {
            for i in 0 ..< list.count {
                let currAngle = asteroids[key]?[i].currAngle
                let yVeloc = asteroids[key]?[i].velocity.y
                let xVeloc = asteroids[key]?[i].velocity.x
                asteroids[key]?[i].accleration = (x: sin(currAngle!) * 35.0, y: -cos(currAngle!) * 35.0)
                asteroids[key]?[i].currPos.x += xVeloc!
                asteroids[key]?[i].currPos.y += yVeloc!
                
                if asteroids[key]![i].currPos.x < 0 {
                    asteroids[key]?[i].currPos.x = frame.maxX
                }
                else if asteroids[key]![i].currPos.x > frame.maxX {
                    asteroids[key]?[i].currPos.x = 0
                }
                
                if asteroids[key]![i].currPos.y < 0 {
                    asteroids[key]?[i].currPos.y = frame.maxY
                }
                else if asteroids[key]![i].currPos.y > frame.maxY {
                     asteroids[key]?[i].currPos.y = 0
                }
            }
        }
    }
    
    func positionLaserPoints(elapsedTime : TimeInterval) {
        var indexes : [Int] = []
        for i in 0 ..< lasers.count {
            let currDate : Date = Date()
            if currDate.timeIntervalSince(lasers[i].timeSpawned) > 2 {
                indexes.append(i)
            }
        }
        for i in 0 ..< indexes.count {
            lasers.remove(at: indexes[i])
        }
        for i in 0 ..< lasers.count {
            lasers[i].currPos.x += lasers[i].velocity.x
            lasers[i].currPos.y += lasers[i].velocity.y
        }
        
    }
    
    func updateLasers() {
        if fire && fireCount >= 15 {
            let currDate : Date = Date()
            lasers.append(Laser(accleration: (x: 0.0, y: 0.0), currPos: (x: ship.currPos.x, y: ship.currPos.y), velocity: (x: sin(ship.currAngle) * 3.0, y: -cos(ship.currAngle) * 3.0), currAngle: ship.currAngle, timeSpawned: currDate))
            fireCount = 0
        }
    }
    
    func asteroidTuple() -> [Int : [(x: CGFloat, y: CGFloat)]] {
        var data : [Int : [(x: CGFloat, y: CGFloat)]] = [:]
        for (key, list) in asteroids {
            var type : Int = 0
            if(key == AsteriodSize.Large) {
                type = 1
            }
            else if key == AsteriodSize.Medium {
                type = 2
            } else {
                type = 3
            }
            var addSizes : [(x: CGFloat, y: CGFloat)] = []
              for asteroid in list {
                addSizes.append((x: asteroid.currPos.x, y: asteroid.currPos.y))
              }
            data[type] = addSizes
            }
        return data
    }
    
    func laserInfo() -> [((x: CGFloat, y: CGFloat), CGFloat)] {
        var data : [((x: CGFloat, y: CGFloat), CGFloat)] = []
        for item in lasers {
            data.append(((x: item.currPos.x, y: item.currPos.y), item.currAngle))
        }
        return data
    }
    
    func updateFrame(newFrame : CGRect) {
        frame = newFrame
        ship.currPos.x = frame.midX
        ship.currPos.y = frame.midY
        
        for (key, list) in asteroids {
            for i in 0 ..< list.count {
                asteroids[key]?[i].currPos.x = frame.midX
                asteroids[key]?[i].currPos.y = frame.midY
                let angle : CGFloat = CGFloat(Double.random(in: 0.0...180.0))
                asteroids[key]?[i].currAngle = angle
                asteroids[key]?[i].velocity = (x: cos(angle), y: sin(angle))
            }
        }
    }
    
    func updateThruster(thrusterOn : Bool) {
        thruster = thrusterOn
    }
    
    func updateLaser(laserOn : Bool) {
        fire = laserOn
    }
}
