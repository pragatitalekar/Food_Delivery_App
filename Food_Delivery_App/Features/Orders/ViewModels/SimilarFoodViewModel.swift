//
//  SimilarFoodViewModel.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/25/26.
//

//
//  SimilarFoodViewModel.swift
//

import Foundation
import Combine

class SimilarFoodViewModel: ObservableObject {
    
    @Published var foods: [FoodItems] = []
    @Published var isLoading = false
    
    // 🔥 Cache to avoid refetching
    private var cachedFoodsByCategory: [CategoryType: [FoodItems]] = [:]
    
    func fetchSimilarFoods(for order: Order, forceRefresh: Bool = false) {
        
        guard let firstItem = order.items.first else { return }
        let category = firstItem.category
        
        // ✅ If cached & no force refresh → use cache
        if let cached = cachedFoodsByCategory[category], !forceRefresh {
            applySmartLogic(items: cached, order: order)
            return
        }
        
        isLoading = true
        
        switch category {
            
        case .meals:
            FoodService.shared.fetchMeals { [weak self] items in
                self?.handleFetched(items: items, category: category, order: order)
            }
            
        case .drinks:
            FoodService.shared.fetchDrinks { [weak self] items in
                self?.handleFetched(items: items, category: category, order: order)
            }
            
        case .snacks:
            FoodService.shared.fetchMeals { [weak self] items in
                self?.handleFetched(items: items, category: category, order: order)
            }
            
        case .desserts:
            FoodService.shared.fetchMeals { [weak self] items in
                self?.handleFetched(items: items, category: category, order: order)
            }
        }
    }
    
    
    // MARK: - Handle Fetched Data
    
    private func handleFetched(items: [FoodItems],
                               category: CategoryType,
                               order: Order) {
        
        DispatchQueue.main.async {
            // 🔥 Cache it
            self.cachedFoodsByCategory[category] = items
            
            self.applySmartLogic(items: items, order: order)
        }
    }
    
    
    // MARK: - Smart Recommendation Logic
    
    private func applySmartLogic(items: [FoodItems], order: Order) {
        
        guard let firstItem = order.items.first else { return }
        
        // 🔥 Remove current ordered item
        var filtered = items.filter {
            $0.id != firstItem.id &&
            $0.category == firstItem.category
        }
        
        // 🔥 Shuffle for randomness
        filtered.shuffle()
        
        // 🔥 Limit to 4 items
        self.foods = Array(filtered.prefix(4))
        
        self.isLoading = false
    }
}
