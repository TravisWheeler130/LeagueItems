//
//  LeagueItem.swift
//  LeagueItems
//
//  Created by Travis Wheeler on 10/2/19.
//  Copyright © 2019 Travis Wheeler. All rights reserved.
//

import Foundation

//struct TopLevelDict {
//    let data: Item
//}

struct Item {
    let name: String
    let description: String
    let plaintext: String
    let image: [String:Any]
    
    // The sprite from the image Dict...
    let sprite: String
}

//struct Image {
//    let sprite: String
//}

extension Item {
    init?(dictionary: [String:Any]) {
        guard let name = dictionary["name"]as? String, let description = dictionary["description"]as? String, let plaintext = dictionary["plaintext"]as? String, let image = dictionary["image"] as? [String:Any], let sprite = image["sprite"] as? String else {return nil}
        
        self.name = name
        self.description = description
        self.plaintext = plaintext
        self.image = image
        self.sprite = sprite
    }
}
