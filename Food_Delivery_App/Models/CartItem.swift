//
//  CartItem.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import Foundation

struct CartItem: Identifiable {
    let id: String
    let item: FoodItems
    var qty: Int
}
