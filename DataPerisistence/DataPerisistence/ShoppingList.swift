//
//  ShoppingList.swift
//  DataPerisistence
//
//  Created by Brandon Ward on 2/25/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import Foundation

struct ShoppingList : Codable {
    enum Error : Swift.Error {
        case endcoding
        case writing
    }
    var storeName : String
    var item : [String]
}

extension Array where Element == ShoppingList {
    func save(to url: URL) throws {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            throw ShoppingList.Error.endcoding
        }
        guard (try? jsonData.write(to: url)) != nil else {
            throw ShoppingList.Error.writing
        }
        //other option ....
//        do {
//            try jsonData.write(to: url)
//        }
//        catch {
//            throw ShoppingList.Error.writing
//        }
        
    }
    
    init(from url: URL) throws {
        let jsonData = try! Data(contentsOf: url)
        self = try JSONDecoder().decode([ShoppingList].self, from: jsonData)
    }
}
