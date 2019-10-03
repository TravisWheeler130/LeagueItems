//
//  LeagueItemController.swift
//  LeagueItems
//
//  Created by Travis Wheeler on 10/2/19.
//  Copyright © 2019 Travis Wheeler. All rights reserved.
//

import Foundation
import UIKit

class LeagueItemController {
    /*
     http://ddragon.leagueoflegends.com/cdn/6.24.1/data/en_US/item.json
     */
    static func fetchItems(completion: @escaping ([Item]) -> Void) {
        
        guard let baseURL = URL(string: "https://ddragon.leagueoflegends.com/cdn/6.24.1/data") else {return}
        
        let languageComponentURL = baseURL.appendingPathComponent("en_US")
        let itemComponentURL = languageComponentURL.appendingPathComponent("item")
        let finalURL = itemComponentURL.appendingPathExtension("json")
        print(finalURL)
        
        // Now that we have a working URL we can start our dataTask
        //fetchPokeDex(with searchTerm: String, completion: @escaping (TopLevelDict?) -> Void)
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
            
            // check for data
            guard let itemData = data else {return}
            // Handle the data
            guard let jsonDictionaries = (try? (JSONSerialization.jsonObject(with: itemData, options: .allowFragments) as! [String:Any])) else {
                print("Error decoding the data? ")
                completion([])
                return
            }
            
            // create a local array of items
            var items: [Item] = []
            guard let dataDictionaries = jsonDictionaries["data"] as? [String:[String:Any]] else {
                return
            }
            
            for dict in dataDictionaries {
                if let newItem = Item(dictionary: dict.value) {
                    items.append(newItem)
                }
            }
            completion(items)
        }.resume()
    }
    
    static func getItemImagefor(item: [Item], completion: @escaping (UIImage?) -> Void) {
        let image = 
        guard let imageURLAsString = item.image.full,
            let url = URL(string: imageURLAsString) else {
                print("Item did not have an image available at url provided")
                completion(nil)
                return
        }
    }
}
