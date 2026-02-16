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
    
    private var timer: Timer?
    
    init() {
        loadOrders()
        startAutoCheck()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    // PLACE ORDER
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

    
    // CANCEL
    func cancelOrder(_ order: Order) {
        guard let index = activeOrders.firstIndex(where: { $0.id == order.id }) else { return }
        
        var cancelled = activeOrders.remove(at: index)
        cancelled.status = .cancelled
        historyOrders.append(cancelled)
        saveOrders()
    }
    
    // TIMER
    func startAutoCheck() {
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.checkOrders()
        }
    }
    
    // CHECK ORDERS
    func checkOrders() {
        let now = Date()
        
        // FILTER instead of index loop
        let completed = activeOrders.filter {
            now.timeIntervalSince($0.createdAt) > 1800 // 30 minutes
        }
        
        completed.forEach { completeOrder($0) }
    }
    
    // COMPLETE
    func completeOrder(_ order: Order) {
        guard let index = activeOrders.firstIndex(where: { $0.id == order.id }) else { return }
        
        var finished = activeOrders.remove(at: index)
        finished.status = .delivered
        historyOrders.append(finished)
        saveOrders()
    }
    
    // SAVE
    func saveOrders() {
        if let data = try? JSONEncoder().encode(activeOrders) {
            UserDefaults.standard.set(data, forKey: "activeOrders")
        }
        
        if let data = try? JSONEncoder().encode(historyOrders) {
            UserDefaults.standard.set(data, forKey: "historyOrders")
        }
    }
    
    // LOAD
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
