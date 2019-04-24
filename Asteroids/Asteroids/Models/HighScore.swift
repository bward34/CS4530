//
//  HighScore.swift
//  Asteroids
//
//  Created by Brandon Ward on 4/6/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import Foundation

class HighScore : Codable {
    
    var playerName : String
    var playerScore : String
    
    init() {
        playerName = ""
        playerScore = "0"
    }
    
    enum CodingKeys : CodingKey {
        case playerName
        case playerScore
    }
    
    enum Error: Swift.Error {
        case encoding
        case writing
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        playerName = try values.decode(String.self, forKey: .playerName)
        playerScore = try values.decode(String.self, forKey: .playerScore)
    }
}

extension Array where Element == HighScore {
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
        self = try JSONDecoder().decode([HighScore].self, from: jsonData)
    }
}
