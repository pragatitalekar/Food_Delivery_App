//
//  PersistenceService.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/10/26.
//

import Foundation

class PersistenceService {

    static let shared = PersistenceService()
    private init() {}

    private let favouritesKey = "favourites"

    
    func saveFavourites(_ favourites: Set<String>) {
        UserDefaults.standard.set(Array(favourites), forKey: favouritesKey)
    }

  
    func loadFavourites() -> Set<String> {
        if let saved = UserDefaults.standard.array(forKey: favouritesKey) as? [String] {
            return Set(saved)
        }
        return []
    }
}

