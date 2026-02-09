//
//  HomeViewModel.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/7/26.
//

import Foundation

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allItems: [FoodItems] = []

    func fetchAll() {
        fetchMeals()
        fetchDrinks()
        fetchSnacks()
        fetchDesserts()
       
    }
    
    func fetchMeals() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data,
                  
                    let decoded = try? JSONDecoder().decode(MealResponse.self, from: data) else { return }
            let items = decoded.meals.map{
                FoodItems(
                    id:$0.idMeal,
                    name: $0.strMeal,
                    image:$0.strMealThumb,
                    description:$0.strInstructions,
                    price: Double.random(in: 150...350),
                    category: .meals
                    
                )
            }
            DispatchQueue.main.async {
                self.allItems += items
            }
        }.resume()
        
    
    }
    func fetchDrinks() {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=")else { return }
        URLSession.shared.dataTask(with: url){(data, _, _) in
            guard let data,
                  let decoded = try? JSONDecoder().decode(DrinkResponse.self, from: data) else{return}
            let items = decoded.drinks.map{
                FoodItems(
                    id:$0.idDrink,
                    name:$0.strDrink,
                    image: $0.strDrinkThumb,
                    description: $0.strInstructions,
                    price:  Double.random(in: 50...200),
                    category: .drinks
                )
            }
            DispatchQueue.main.async{
                self.allItems += items
            }
            
        }.resume()
    }
    
    func fetchSnacks() {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=Side")else {return}
        
        URLSession.shared.dataTask(with: url){(data, _, _) in
            guard let data,
                  let decoded = try? JSONDecoder().decode(CategoryMealResponse.self, from: data)else {return}
            
            decoded.meals.prefix(10).forEach{ meals in
                self.lookupDetail(id: meals.idMeal, category: .snacks)
                
                
            }
        }.resume()
        
    }
    func fetchDesserts() {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=Desert")else {return}
        
        URLSession.shared.dataTask(with: url){(data, _, _) in
            guard let data,
                  let decoded = try? JSONDecoder().decode(CategoryMealResponse.self, from: data)else {return}
            
            decoded.meals.prefix(10).forEach{meals in
                self.lookupDetail(id: meals.idMeal, category: .desserts)
            }
        }.resume()
        
    }
    func lookupDetail(id: UUID, category: CategoryType) {
            guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else { return }

            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data,
                      let decoded = try? JSONDecoder().decode(LookUpRespone.self, from: data),
                      let meal = decoded.meals.first else { return }

                let item = FoodItems(
                    id: meal.idMeal,
                    name: meal.strMeal,
                    image: meal.strMealThumb,
                    description: meal.strInstructions,
                    price: Double.random(in: 70...180),
                    category: category
                )

                DispatchQueue.main.async {
                    self.allItems.append(item)
                }
            }.resume()
        }

}
