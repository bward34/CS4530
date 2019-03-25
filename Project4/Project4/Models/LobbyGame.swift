//
//  LobbyGame.swift
//  Project3 - Project4
//
//  Created by Brandon Ward on 3/19/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import Foundation

class LobbyGame: Codable {
    
    var id: String
    var name: String
    var status: String
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case status
    }
    
    enum Error: Swift.Error {
        case encoding
        case writing
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        status = try values.decode(String.self, forKey: .status)
    }
}

extension Array where Element == LobbyGame {

    init(from url: URL) throws {
        let jsonData = try! Data(contentsOf: url)
        self = try JSONDecoder().decode([LobbyGame].self, from: jsonData)
    }
}
