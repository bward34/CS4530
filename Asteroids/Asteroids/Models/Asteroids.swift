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
    var asteroidCount : Int
    var listEmptyCount : Int
    var shipRespwanedDate : Date
    var shipNeedsRespwan : Bool
    var gameInProgresss : Bool
    var gameComplete : Bool
    
    enum AsteroidKeys : CodingKey {
        case ship
        case asteroids
        case asteroidCount
        case lives
        case score
        case frame
        case gameProgress
        case gameComplete
        case smallEmpty
        case largeEmpty
        case mediumEmpty
        case listCount
    }
    
    init() {
        asteroidCount = 0
        listEmptyCount = 0
        fireCount = 0
        frame = CGRect()
        gameLoop = Timer()
        oldTime = Date()
        lives = 3
        score = 0
        lasers = []
        asteroids = [1 : [], 2 : [], 3: []]
        thruster = false
        fire = false
        rotateLeft = false
        rotateRight = false
        shipRespwanedDate = Date()
        shipNeedsRespwan = false
        gameComplete = false
        gameInProgresss = false
        ship = Ship(acclerationX: 0.0, acclerationY: 0.0, velocityX: 0.0, velocityY: 0.0, currPosX: 0.0, currPosY: 0.0, currAngle: 0.0)
    }
    
    func startTimer() {
        gameLoop = Timer.scheduledTimer(withTimeInterval: 1 / 120, repeats: true, block: { gameLoop in
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
                    objectRadius = 37.5
                }
                else if size == 2 {
                    objectRadius = 17.5
                }
                else {
                    objectRadius = 10.0
                }
                    for i in 0 ..< list.count {
                        for (index, item) in lasers.enumerated() {
                            let xDiffLaser : Double = Double(item.currPos.x - list[i].currPosX)
                            let yDiffLaser : Double = Double(item.currPos.y - list[i].currPosY)
                            let radiusLaser : Double = Double(objectRadius + 2.0)
                            if pow(xDiffLaser, 2) + pow(yDiffLaser, 2) <=  pow(radiusLaser, 2) {
                                lasers.remove(at: index)
                                popPushAsteroid(size: size, asteroid: list[i], index: i)
                                print("lasers Colided \(Date())")
                            }
                        }
                        let xDiffShip : Double = Double(ship.currPosX - list[i].currPosX)
                        let yDiffShip : Double = Double(ship.currPosY - list[i].currPosY)
                        let radiusShip : Double = Double(objectRadius + 10.0)
                        if pow(xDiffShip, 2) + pow(yDiffShip, 2) <=  pow(radiusShip, 2) && (ship.currPosX != 0.0 && ship.currPosY != 0.0) {
                            print("Ship Colided \(Date())")
                            let currentDate : Date = Date()
                            let elapsed : TimeInterval = currentDate.timeIntervalSince(shipRespwanedDate)
                            if elapsed > 3 {
                                respawnShip()
                            }
                            else {
                                shipNeedsRespwan = false
                            }
                    }
            }
        }
    }
    
    func respawnShip() {
        lives -= 1
        if lives != 0 {
            ship.currPosX = Float(frame.midX)
            ship.currPosY = Float(frame.midY)
            shipRespwanedDate = Date()
            shipNeedsRespwan = true
        }
        else {
            gameLoop.invalidate()
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
                newAsteroid.velocityY = sin(angle)
                asteroids[2]?.append(newAsteroid)
                count += 1
            }
            score += 100
            if asteroids[size]?.count == 0 {
                listEmptyCount += 1
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
                newAsteroid.velocityY = sin(angle)
                asteroids[3]?.append(newAsteroid)
                count += 1
            }
            score += 150
            if asteroids[size]?.count == 0 {
                listEmptyCount += 1
            }
        }
        else {
          asteroids[size]?.remove(at: index)
            score += 200
            if asteroids[size]?.count == 0 {
                listEmptyCount += 1
            }
        }
        if listEmptyCount == 3 {
            listEmptyCount = 0
            lives = 3
            asteroidCount += 1
            addAsteroids()
        }
    }
    
    func positionShip(elapsedTime : TimeInterval) {
        if rotateLeft {
            ship.currAngle -= (3.0 * .pi) / 180.0
        }
        
        if rotateRight {
           ship.currAngle += (3.0 * .pi) / 180.0
        }
        
        if thruster {
            ship.acclerationX =  sin(ship.currAngle) * 350.0
            ship.acclerationY =  -cos(ship.currAngle) * 350.0
            ship.velocityX += ship.acclerationX * Float(elapsedTime)
            ship.velocityY += ship.acclerationY * Float(elapsedTime)
        }
        else {
            ship.acclerationX =  -ship.velocityX * 3.0
            ship.acclerationY =  -ship.velocityY * 3.0
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
            lasers.append(Laser(accleration: (x: 0.0, y: 0.0), currPos: (x: ship.currPosX, y: ship.currPosY), velocity: (x: sin(ship.currAngle) * 1.5, y: -cos(ship.currAngle) * 1.5), currAngle: ship.currAngle, timeSpawned: currDate))
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
    
    func addAsteroids() {
        
        let angleOne : Float = Float.random(in: 0.0...180.0)
        let angleTwo : Float = Float.random(in: 0.0...180.0)
        let angleThree : Float = Float.random(in: 0.0...180.0)
        let angleFour : Float = Float.random(in: 0.0...180.0)
        
        asteroids[1]?.append(Asteroid(velocityX: cos(angleOne) * 0.5, velocityY: sin(angleOne) * 0.5, currPosX: 0.0, currPosY: 0.0, currAngle: angleOne))
        asteroids[1]?.append(Asteroid(velocityX: cos(angleTwo) * 0.5, velocityY: sin(angleTwo) * 0.5, currPosX: Float(frame.midX), currPosY: 0.0, currAngle: angleTwo))
        asteroids[1]?.append(Asteroid(velocityX: cos(angleThree) * 0.5, velocityY: sin(angleThree) * 0.5, currPosX: 0.0, currPosY: Float(frame.height), currAngle: angleThree))
        asteroids[1]?.append(Asteroid(velocityX: cos(angleFour) * 0.5, velocityY: sin(angleFour) * 0.5, currPosX: Float(frame.midX), currPosY: Float(frame.height), currAngle: angleFour))
        
        for _ in 0 ..< asteroidCount {
            let angle : Float = Float.random(in: 0.0...180.0)
            let randIndex : Int = Int.random(in: 0...3)
            let posArray : [CGFloat] = [frame.height * 0.33, frame.height * 0.5, frame.height * 0.66, frame.height]
            asteroids[1]?.append(Asteroid(velocityX: cos(angle) * 0.5, velocityY: sin(angle) * 0.5, currPosX: 0.0, currPosY: Float(posArray[randIndex]), currAngle: angle))
        }
        
    }
    
    func updateFrame(newFrame : CGRect) {
        if !gameInProgresss {
            gameInProgresss = true
            frame = newFrame
            ship.currPosX = Float(frame.midX)
            ship.currPosY = Float(frame.midY)
            
            let angleOne : Float = Float.random(in: 0.0...180.0)
            let angleTwo : Float = Float.random(in: 0.0...180.0)
            let angleThree : Float = Float.random(in: 0.0...180.0)
            let angleFour : Float = Float.random(in: 0.0...180.0)
            
            asteroids[1]?.append(Asteroid(velocityX: cos(angleOne) * 0.5, velocityY: sin(angleOne) * 0.5, currPosX: 0.0, currPosY: 0.0, currAngle: angleOne))
            asteroids[1]?.append(Asteroid(velocityX: cos(angleTwo) * 0.5, velocityY: sin(angleTwo) * 0.5, currPosX: Float(frame.midX), currPosY: 0.0, currAngle: angleTwo))
            asteroids[1]?.append(Asteroid(velocityX: cos(angleThree) * 0.5, velocityY: sin(angleThree) * 0.5, currPosX: 0.0, currPosY: Float(frame.height), currAngle: angleThree))
            asteroids[1]?.append(Asteroid(velocityX: cos(angleFour) * 0.5, velocityY: sin(angleFour) * 0.5, currPosX: Float(frame.midX), currPosY: Float(frame.height), currAngle: angleFour))
            
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
    
    // MARK: Encoding/Decoding
    
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
        frame = try values.decode(CGRect.self, forKey: AsteroidKeys.frame)
        asteroidCount = try values.decode(Int.self, forKey: AsteroidKeys.asteroidCount)
        gameInProgresss = try values.decode(Bool.self, forKey: AsteroidKeys.gameProgress)
        gameComplete = try values.decode(Bool.self, forKey: AsteroidKeys.gameComplete)
        listEmptyCount = try values.decode(Int.self, forKey: AsteroidKeys.listCount)
        gameLoop = Timer()
        oldTime = Date()
        shipRespwanedDate = Date()
        thruster = false
        fire = false
        rotateLeft = false
        rotateRight = false
        lasers = []
        fireCount = 0
        shipNeedsRespwan = false
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AsteroidKeys.self)
        try container.encode(ship, forKey: AsteroidKeys.ship)
        try container.encode(score, forKey: AsteroidKeys.score)
        try container.encode(lives, forKey: AsteroidKeys.lives)
        try container.encode(asteroids, forKey: AsteroidKeys.asteroids)
        try container.encode(frame, forKey: AsteroidKeys.frame)
        try container.encode(asteroidCount, forKey: AsteroidKeys.asteroidCount)
        try container.encode(gameInProgresss, forKey: AsteroidKeys.gameProgress)
        try container.encode(gameComplete, forKey: AsteroidKeys.gameComplete)
        try container.encode(listEmptyCount, forKey: AsteroidKeys.listCount)
    }
    
    enum Error: Swift.Error {
        case encoding
        case writing
    }
    
}

// MARK: Extensions for Encoding/Decoding
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
            throw Asteriods.Error.writing
        }
    }
    
    init(from url: URL) throws {
        let jsonData = try! Data(contentsOf: url)
        self = try JSONDecoder().decode([Asteroid].self, from: jsonData)
    }
}

extension CGRect {
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
        self = try JSONDecoder().decode(CGRect.self, from: jsonData)
    }
}
