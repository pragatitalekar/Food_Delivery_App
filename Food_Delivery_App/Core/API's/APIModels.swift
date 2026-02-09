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
    let idMeal: UUID
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String
}

struct DrinkResponse: Codable {
    let drinks: [Drink]
}
struct Drink: Codable {
    let idDrink: UUID
    let strDrink: String
    let strDrinkThumb: String
    let strInstructions: String
}

struct CategoryMealResponse: Codable {
    let meals: [CategoryMeal]
}

struct CategoryMeal: Codable {
    let idMeal: UUID
    let strMeal: String
    let strMealThumb: String
}

struct LookUpRespone: Codable {
    let meals: [Meal]
    let drinks: [Drink]
    let mealsCategories: [CategoryMeal]
}
