//
//  HomeViewModel.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/7/26.
//
import Foundation
import Combine

class HomeViewModel: ObservableObject {

    @Published var showNoInternet = false
    @Published var allItems: [FoodItems] = []

    private let service = FoodService.shared
    
    private let networkMonitor = NetworkMonitor.shared

    func fetchAll() {
        allItems.removeAll()
        guard networkMonitor.isConnected else {
                showNoInternet = true
                return
            }
        showNoInternet = false


        fetchMeals()
        fetchDrinks()
        fetchSnacks()
        fetchDesserts()
    }

    private func fetchMeals() {
        service.fetchMeals { items in
            self.allItems += items
        }
    }

    private func fetchDrinks() {
        service.fetchDrinks { items in
            self.allItems += items
        }
    }

    private func fetchSnacks() {
        service.fetchCategoryMeals(
            urlString: APIConstants.snackCategory,
            category: .snacks
        ) { items in
            self.allItems += items
        }
    }

    private func fetchDesserts() {
        service.fetchCategoryMeals(
            urlString: APIConstants.dessertCategory,
            category: .desserts
        ) { items in
            self.allItems += items
        }
    }
}
