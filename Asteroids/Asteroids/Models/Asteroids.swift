//
//  Asteroids.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/4/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import Foundation
import UIKit

struct Ship : Codable {
    var acclerationX : Float
    var acclerationY : Float
    var velocityX : Float
    var velocityY : Float
    var currPosX : Float
    var currPosY : Float
    var currAngle : Float
}

struct Asteroid : Codable {
    var velocityX : Float
    var velocityY : Float
    var currPosX : Float
    var currPosY : Float
    var currAngle : Float
}

struct Laser {
   var accleration : (x : Float, y : Float)
   var currPos : (x : Float, y : Float)
   var velocity : (x : Float, y : Float)
   var currAngle : Float
   var timeSpawned : Date
}

class Asteriods : Codable {
    
    var ship : Ship
    var frame : CGRect
    var gameLoop : Timer
    var oldTime : Date
    var thruster : Bool
    var fire : Bool
    var rotateLeft : Bool
    var rotateRight : Bool
    var asteroids : [Int : [Asteroid]]
    var lasers : [Laser]
    var fireCount : Int
    var lives : Int
    var score : Int
    
    enum AsteroidKeys : CodingKey {
        case ship
        case asteroids
        case lives
        case score
        case frameWidth
        case frameHeight
    }
    
    init() {
        fireCount = 0
        frame = CGRect()
        gameLoop = Timer()
        oldTime = Date()
        lives = 3
        score = 0
        lasers = []
        asteroids = [1 :
                    [Asteroid(velocityX: 0.0, velocityY: 0.0, currPosX: 0.0, currPosY: 0.0, currAngle: 0.0),
                     Asteroid(velocityX: 0.0, velocityY: 0.0, currPosX: 0.0, currPosY: 0.0, currAngle: 0.0),
                     Asteroid(velocityX: 0.0, velocityY: 0.0, currPosX: 0.0, currPosY: 0.0, currAngle: 0.0),
                     Asteroid(velocityX: 0.0, velocityY: 0.0, currPosX: 0.0, currPosY: 0.0, currAngle: 0.0)],
                     2 : [],
                     3: []]
        thruster = false
        fire = false
        rotateLeft = false
        rotateRight = false
        ship = Ship(acclerationX: 0.0, acclerationY: 0.0, velocityX: 0.0, velocityY: 0.0, currPosX: 0.0, currPosY: 0.0, currAngle: 0.0)
    }
    
    func startTimer() {
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
        self.detectCollision()
        self.fireCount = self.fireCount + 1
    }
    
    func detectCollision() {
            for (size, list) in asteroids {
                let objectRadius : Double
                if size == 1{
                    objectRadius = 50.0
                }
                else if size == 2 {
                    objectRadius = 30.0
                }
                else {
                    objectRadius = 15.0
                }
                for i in 0 ..< list.count {
                    for j in 0 ..< lasers.count {
                        let xDiffLaser : Double = Double(lasers[j].currPos.x - list[i].currPosX)
                        let yDiffLaser : Double = Double(lasers[j].currPos.y - list[i].currPosY)
                        let radiusLaser : Double = Double(objectRadius + 2.0)
                        if pow(xDiffLaser, 2) + pow(yDiffLaser, 2) <=  pow(radiusLaser, 2) {
                            lasers.remove(at: j)
                            popPushAsteroid(size: size, asteroid: list[i], index: i)
                            print("lasers Colided \(Date())")
                        }
                    }
                    let xDiffShip : Double = Double(ship.currPosX - list[i].currPosX)
                    let yDiffShip : Double = Double(ship.currPosY - list[i].currPosY)
                    let radiusShip : Double = Double(objectRadius + 15.0)
                    if pow(xDiffShip, 2) + pow(yDiffShip, 2) <=  pow(radiusShip, 2) && (ship.currPosX != 0.0 && ship.currPosY != 0.0) {
                        print("Ship Colided \(Date())")
                        lives -= 1
                        return
                    }
                }
        }
    }
    
    func popPushAsteroid(size : Int, asteroid : Asteroid, index : Int) {
        if size == 1 {
            asteroids[size]?.remove(at: index)
            var count : Int = 0
            while count < 2 {
                var newAsteroid : Asteroid = Asteroid(velocityX: 0.0, velocityY: 0.0, currPosX: 0.0, currPosY: 0.0, currAngle: 0.0)
                newAsteroid.currPosX = asteroid.currPosX
                newAsteroid.currPosY = asteroid.currPosY
                let angle : Float = Float.random(in: 0.0...180.0)
                newAsteroid.currAngle = angle
                newAsteroid.velocityX = cos(angle)
                newAsteroid.velocityX = sin(angle)
                asteroids[2]?.append(newAsteroid)
                count += 1
            }
        }
        else if size == 2 {
            asteroids[size]?.remove(at: index)
            var count : Int = 0
            while count < 2 {
                var newAsteroid : Asteroid = Asteroid(velocityX: 0.0, velocityY: 0.0, currPosX: 0.0, currPosY: 0.0, currAngle: 0.0)
                newAsteroid.currPosX = asteroid.currPosX
                newAsteroid.currPosY = asteroid.currPosY
                let angle : Float = Float.random(in: 0.0...180.0)
                newAsteroid.currAngle = angle
                newAsteroid.velocityX = cos(angle)
                newAsteroid.velocityX = sin(angle)
                asteroids[3]?.append(newAsteroid)
                count += 1
            }
        }
        else {
          asteroids[size]?.remove(at: index)
        }
    }
    
    func positionShip(elapsedTime : TimeInterval) {
        if rotateLeft {
            ship.currAngle -= (2.0 * .pi) / 180.0
        }
        
        if rotateRight {
           ship.currAngle += (2.0 * .pi) / 180.0
        }
        
        if thruster {
            ship.acclerationX =  sin(ship.currAngle) * 40.0
            ship.acclerationY =  -cos(ship.currAngle) * 40.0
            ship.velocityX += ship.acclerationX * Float(elapsedTime)
            ship.velocityY += ship.acclerationY * Float(elapsedTime)
        }
        else {
            ship.acclerationX =  -ship.velocityX * 1.3
            ship.acclerationY =  -ship.velocityY * 1.3
            ship.velocityX -= ship.acclerationX * Float(elapsedTime)
            ship.velocityY -= ship.acclerationY * Float(elapsedTime)
        }

        ship.currPosX += ship.velocityX * Float(elapsedTime)
        ship.currPosY += ship.velocityY * Float(elapsedTime)
        
        if ship.currPosX < 0 {
            ship.currPosX = Float(frame.maxX)
        }
        else if ship.currPosX > Float(frame.maxX) {
            ship.currPosX = 0
        }
        
        if ship.currPosY < 0 {
            ship.currPosY = Float(frame.maxY)
        }
        else if ship.currPosY > Float(frame.maxY) {
            ship.currPosY = 0
        }
    }
    
    func positionAsteroids(elapsedTime : TimeInterval) {
        for (key, list) in asteroids {
            for i in 0 ..< list.count {
                let yVeloc = asteroids[key]?[i].velocityY
                let xVeloc = asteroids[key]?[i].velocityX
                asteroids[key]?[i].currPosX += xVeloc!
                asteroids[key]?[i].currPosY += yVeloc!
                
                if asteroids[key]![i].currPosX < 0 {
                    asteroids[key]?[i].currPosX = Float(frame.maxX)
                }
                else if asteroids[key]![i].currPosX > Float(frame.maxX) {
                    asteroids[key]?[i].currPosX = 0
                }
                
                if asteroids[key]![i].currPosY < 0 {
                    asteroids[key]?[i].currPosY = Float(frame.maxY)
                }
                else if asteroids[key]![i].currPosY > Float(frame.maxY) {
                     asteroids[key]?[i].currPosY = 0
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
            if lasers[i].currPos.x < 0 {
                lasers[i].currPos.x = Float(frame.maxX)
            }
            else if lasers[i].currPos.x > Float(frame.maxX) {
                lasers[i].currPos.x = 0
            }
            
            if lasers[i].currPos.y < 0 {
                lasers[i].currPos.y = Float(frame.maxY)
            }
            else if lasers[i].currPos.y > Float(frame.maxY) {
                lasers[i].currPos.y = 0
            }
        }
        
    }
    
    func updateLasers() {
        if fire && fireCount >= 15 {
            let currDate : Date = Date()
            lasers.append(Laser(accleration: (x: 0.0, y: 0.0), currPos: (x: ship.currPosX, y: ship.currPosY), velocity: (x: sin(ship.currAngle) * 3.0, y: -cos(ship.currAngle) * 3.0), currAngle: ship.currAngle, timeSpawned: currDate))
            fireCount = 0
        }
    }
    
    func asteroidInfo() -> [Int : [(x: CGFloat, y: CGFloat)]] {
        var data : [Int : [(x: CGFloat, y: CGFloat)]] = [:]
        for (key, list) in asteroids {
            var addSizes : [(x: CGFloat, y: CGFloat)] = []
              for asteroid in list {
                addSizes.append((x: CGFloat(asteroid.currPosX), y: CGFloat(asteroid.currPosY)))
              }
            data[key] = addSizes
            }
        return data
    }
    
    func laserInfo() -> [((x: CGFloat, y: CGFloat), CGFloat)] {
        var data : [((x: CGFloat, y: CGFloat), CGFloat)] = []
        for item in lasers {
            data.append(((x: CGFloat(item.currPos.x), y: CGFloat(item.currPos.y)), CGFloat(item.currAngle)))
        }
        return data
    }
    
    func updateFrame(newFrame : CGRect) {
        frame = newFrame
        ship.currPosX = Float(frame.midX)
        ship.currPosY = Float(frame.midY)
        
        for (key, list) in asteroids {
            for i in 0 ..< list.count {
                asteroids[key]?[i].currPosX = Float(frame.midX)
                asteroids[key]?[i].currPosY = 0.0
                let angle :Float = Float.random(in: 0.0...180.0)
                asteroids[key]?[i].currAngle = angle
                asteroids[key]?[i].velocityX = cos(angle) * 0.8
                asteroids[key]?[i].velocityY = sin(angle) * 0.8
            }
        }
    }
    
    func updateThruster(thrusterOn : Bool) {
        thruster = thrusterOn
    }
    
    func updateLaser(laserOn : Bool) {
        fire = laserOn
    }
    
    func updateLeftRotate(rotate : Bool) {
        rotateLeft = rotate
    }
    
    func updateRightRotate(rotate : Bool) {
        rotateRight = rotate
    }
    
    func save(to url: URL) throws {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            throw Asteriods.Error.encoding
        }
        guard (try? jsonData.write(to: url)) != nil else {
            throw Asteriods.Error.writing
        }
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: AsteroidKeys.self)
        ship = try values.decode(Ship.self, forKey: AsteroidKeys.ship)
        asteroids = try values.decode([Int : [Asteroid]].self, forKey: AsteroidKeys.asteroids)
        score = try values.decode(Int.self, forKey: AsteroidKeys.score)
        lives = try values.decode(Int.self, forKey: AsteroidKeys.lives)
        frame = CGRect()
        gameLoop = Timer()
        oldTime = Date()
        thruster = false
        fire = false
        rotateLeft = false
        rotateRight = false
        lasers = []
        fireCount = 0
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AsteroidKeys.self)
        try container.encode(ship, forKey: AsteroidKeys.ship)
        try container.encode(score, forKey: AsteroidKeys.score)
        try container.encode(lives, forKey: AsteroidKeys.lives)
        try container.encode(asteroids, forKey: AsteroidKeys.asteroids)
    }
    
    enum Error: Swift.Error {
        case encoding
        case writing
    }
    
}
extension Dictionary where Dictionary<Key, Value> == [Int : [Asteroid]] {
    func save(to url: URL) throws {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            throw Asteriods.Error.encoding
        }
        guard (try? jsonData.write(to: url)) != nil else {
            throw Asteriods.Error.writing
        }
    }
    
    init(from url: URL) throws {
        let jsonData = try! Data(contentsOf: url)
        self = try JSONDecoder().decode([Int : [Asteroid]].self, from: jsonData)
    }
}

extension Array where Element == Asteroid {
    func save(to url: URL) throws {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            throw Asteriods.Error.encoding
        }
        guard (try? jsonData.write(to: url)) != nil else {
            throw Asteriods.Error.encoding
        }
        
    }
    
    init(from url: URL) throws {
        let jsonData = try! Data(contentsOf: url)
        self = try JSONDecoder().decode([Asteroid].self, from: jsonData)
    }
}
