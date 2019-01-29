// Project 0 - Shopping List
// Brandon Ward, u0838890
//
//  main.swift
//  ShoppingList
//
//  Created by Brandon Ward on 1/7/19.
//  Copyright © 2019 CS4530. All rights reserved.
//
import Foundation

print("Enter in your shopping list. If you want more than one of a particular item then give the item and quantity seperated with a colon (:) i.e. apple: 2 (Note that item will not be added if not in this format.) To finish list, leave line blank and press enter.")

var items: [String : Int ] = [:]

while let input = readLine() {
    
    //Checks if end of shopping list
    if(input == "") {
        break
    }
    
    var itemArray = input.split(separator: ":").map(String.init)
    //trims whitespace to get list item
    
    if(itemArray.count != 0) {
        let item = String(itemArray[0]).trimmingCharacters(in: CharacterSet.whitespaces)
        var quant = 0
        
        //gets quantity
        if((itemArray.count != 2)  || (itemArray[1].trimmingCharacters(in: CharacterSet.whitespaces) == "")) {
            quant = 1
        } else {
            quant = Int(itemArray[1].trimmingCharacters(in: CharacterSet.whitespaces)) ?? 0
        }
        //adds items to dictionary
        if let numItems = items[item] {
            quant += numItems
            items[item] = quant
        }
        else {
            items.updateValue(quant, forKey: item)
        }
    }
}

//puts items in alphabetical order by adding them to an array
var itemsArray = [String] (items.keys)
itemsArray.sort()

//prints list in correct format
print("Shopping List")
var listNum = 1
for item in itemsArray {
    if let quantity = items[item] {
        print("\(listNum). \(item): \(quantity)")
        listNum = listNum + 1
    }
    
}
