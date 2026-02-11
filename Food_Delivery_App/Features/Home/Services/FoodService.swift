//
//  FoodService.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import Foundation

class FoodService {

    static let shared = FoodService()
    private init() {}

    func fetchMeals(completion: @escaping ([FoodItems]) -> Void) {
        guard let url = URL(string: APIConstants.mealSearch) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data,
                  let decoded = try? JSONDecoder().decode(MealResponse.self, from: data) else { return }

            let items = decoded.meals.map {
                FoodItems(
                    id: $0.idMeal,
                    name: $0.strMeal,
                    image: $0.strMealThumb,
                    price: Double.random(in: 150...350),
                    category: .meals
                )
            }

            DispatchQueue.main.async {
                completion(items)
            }
        }.resume()
    }

    func fetchDrinks(completion: @escaping ([FoodItems]) -> Void) {
        guard let url = URL(string: APIConstants.drinkSearch) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data,
                  let decoded = try? JSONDecoder().decode(DrinkResponse.self, from: data) else { return }

            let items = decoded.drinks.map {
                FoodItems(
                    id: $0.idDrink,
                    name: $0.strDrink,
                    image: $0.strDrinkThumb,
                    price: Double.random(in: 50...200),
                    category: .drinks
                )
            }

            DispatchQueue.main.async {
                completion(items)
            }
        }.resume()
    }

    func fetchCategoryMeals(urlString: String,
                            category: CategoryType,
                            completion: @escaping ([FoodItems]) -> Void) {

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data,
                  let decoded = try? JSONDecoder().decode(CategoryMealResponse.self, from: data) else { return }

            let ids = decoded.meals.prefix(10).map { $0.idMeal }
            self.lookupDetails(ids: ids, category: category, completion: completion)
        }.resume()
    }

    private func lookupDetails(ids: [String],
                               category: CategoryType,
                               completion: @escaping ([FoodItems]) -> Void) {

        var results: [FoodItems] = []
        let group = DispatchGroup()

        for id in ids {
            group.enter()
            guard let url = URL(string: APIConstants.lookupMeal + id) else { continue }

            URLSession.shared.dataTask(with: url) { data, _, _ in
                defer { group.leave() }

                guard let data,
                      let decoded = try? JSONDecoder().decode(LookupResponse.self, from: data),
                      let meal = decoded.meals.first else { return }

                let item = FoodItems(
                    id: meal.idMeal,
                    name: meal.strMeal,
                    image: meal.strMealThumb,
                    price: Double.random(in: 70...180),
                    category: category
                )

                results.append(item)
            }.resume()
        }

        group.notify(queue: .main) {
            completion(results)
        }
    }
}
