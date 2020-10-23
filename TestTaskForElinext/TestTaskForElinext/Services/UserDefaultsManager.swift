//
//  UserDefaultsManager.swift
//  TestTaskForElinext
//
//  Created by Batman on 10/22/20.
//

import Foundation

class UserDefaultsManager {
    
    let defaults = UserDefaults.standard
    
    static let shared = UserDefaultsManager()
    private init () {}
    
    //MARK: - Flow Functions
    
    func saveData(_ data: [City]) {
        defaults.set(try? PropertyListEncoder().encode(data), forKey: "savedCitiesArray")
    }
    
    func loadData() -> [City] {
        if let data = defaults.value(forKey: "savedCitiesArray") as? Data {
            if let decodedCitiesArray = try? PropertyListDecoder().decode(Array<City>.self, from: data) {
                return decodedCitiesArray
            }
        }
        return JSONParsingService.shared.parsingCitiesDataFromJson()
    }
    
}
