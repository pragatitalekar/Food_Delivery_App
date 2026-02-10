//
//  Models.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/8/26.
//

import Foundation
enum CategoryType: String, CaseIterable {
    case meals = "Meals"
    case drinks = "Drinks"
    case snacks = "Snacks"
    case desserts = "Desserts"
}

struct FoodItems: Identifiable {
    let id: String
    let name: String
    let image: String
    let price: Double
    let category: CategoryType
}

