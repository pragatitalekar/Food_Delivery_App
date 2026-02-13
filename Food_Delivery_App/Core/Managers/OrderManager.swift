//
//  OrderManager.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/12/26.
//

import SwiftUI
import Combine

class OrderManager: ObservableObject {
   
    
    
    @Published var activeOrders: [Order] = []
    @Published var historyOrders: [Order] = []
    
    init() {
        loadOrders()
        startAutoCheck()
    }
    
  
    func placeOrder(items: [FoodItems], total: Double) {
        let order = Order(
            id: UUID().uuidString,
            items: items,
            total: total,
            createdAt: Date(),
            status: .preparing
        )
        
        activeOrders.append(order)
        saveOrders()
    }

    func cancelOrder(_ order: Order) {
        if let index = activeOrders.firstIndex(where: { $0.id == order.id }) {
            var cancelled = activeOrders.remove(at: index)
            cancelled.status = .cancelled
            historyOrders.append(cancelled)
            saveOrders()
        }
    }

    
    func startAutoCheck() {
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            self.checkOrders()
        }
    }
    
    func checkOrders() {
        let now = Date()
        
        for i in activeOrders.indices {
            let order = activeOrders[i]
            if now.timeIntervalSince(order.createdAt) > 30 { // 30 min
                completeOrder(order)
            }
        }
    }
    
    
    func completeOrder(_ order: Order) {
        if let index = activeOrders.firstIndex(where: { $0.id == order.id }) {
            var finished = activeOrders.remove(at: index)
            finished.status = .delivered
            historyOrders.append(finished)
            saveOrders()
        }
    }

    
  
    func saveOrders() {
        if let data = try? JSONEncoder().encode(activeOrders) {
            UserDefaults.standard.set(data, forKey: "activeOrders")
        }
        if let data = try? JSONEncoder().encode(historyOrders) {
            UserDefaults.standard.set(data, forKey: "historyOrders")
        }
    }
    
    
    func loadOrders() {
        if let data = UserDefaults.standard.data(forKey: "activeOrders"),
           let decoded = try? JSONDecoder().decode([Order].self, from: data) {
            activeOrders = decoded
        }
        
        if let data = UserDefaults.standard.data(forKey: "historyOrders"),
           let decoded = try? JSONDecoder().decode([Order].self, from: data) {
            historyOrders = decoded
        }
    }
}
