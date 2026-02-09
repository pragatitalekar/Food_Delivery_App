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

    func add(_ item: FoodItems) {
        items.append(item)
    }

    var total: Double {
        items.reduce(0) { $0 + $1.price }
    }
}
