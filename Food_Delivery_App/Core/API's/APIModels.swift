//
//  APIModels.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/8/26.
//

import Foundation



struct MealResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
  
}

struct DrinkResponse: Codable {
    let drinks: [Drink]
}

struct Drink: Codable {
    let idDrink: String
    let strDrink: String
    let strDrinkThumb: String
   
}

struct CategoryMealResponse: Codable {
    let meals: [CategoryMeal]
}

struct CategoryMeal: Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}

struct LookupResponse: Codable {
    let meals: [Meal]
}
