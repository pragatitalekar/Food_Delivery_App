//
//  APIConstants.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//
import Foundation

struct APIConstants {
    static let baseMeal = "https://www.themealdb.com/api/json/v1/1/"
    
    static let mealSearch = baseMeal + "search.php?s="
    static let snackCategory = baseMeal + "filter.php?c=Side"
    static let dessertCategory = baseMeal + "filter.php?c=Dessert"
    static let lookupMeal = baseMeal + "lookup.php?i="
    
    static let drinkSearch =
    "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=Drink"
}
