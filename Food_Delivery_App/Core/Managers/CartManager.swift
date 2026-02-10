//
//  CartManager.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//
import SwiftUI
import Combine

class CartManager: ObservableObject {
    
    @Published var items: [FoodItems] = []
    @Published var favourites: Set<String> = []  
    
    func add(_ item: FoodItems) {
        items.append(item)
    }
    
    func remove(_ item: FoodItems) {
        items.removeAll { $0.id == item.id }
    }
    
    func toggleFavourite(_ item: FoodItems) {
        if favourites.contains(item.id) {
            favourites.remove(item.id)
        } else {
            favourites.insert(item.id)
        }
    }
    
    func isFavourite(_ item: FoodItems) -> Bool {
        favourites.contains(item.id)
    }
    
    var total: Double {
        items.reduce(0) { $0 + $1.price }
    }
}



