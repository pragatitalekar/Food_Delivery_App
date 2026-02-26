//
//  OrderManager.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/19/26.
//


import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseAuth

class OrderManager: ObservableObject {
    
    private var timer: Timer?
    
    @Published var activeOrders: [Order] = []
    @Published var historyOrders: [Order] = []
    
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    init() {
        startAutoCheck()
    }
    

    
    func listenToOrders() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        listener?.remove() // prevent duplicate listeners
        
        listener = db.collection("users")
            .document(uid)
            .collection("orders")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener { snapshot, error in
                
                guard let documents = snapshot?.documents else { return }
                
                var fetchedOrders: [Order] = []
                
                for doc in documents {
                    
                    let data = doc.data()
                    
                    guard
                        let total = data["total"] as? Double,
                        let timestamp = data["createdAt"] as? Timestamp,
                        let statusRaw = data["status"] as? String,
                        let status = OrderStatus(rawValue: statusRaw),
                        let itemsArray = data["items"] as? [[String: Any]]
                    else { continue }
                    
                    let items: [FoodItems] = itemsArray.compactMap { itemData in
                        guard
                            let id = itemData["id"] as? String,
                            let name = itemData["name"] as? String,
                            let image = itemData["image"] as? String,
                            let price = itemData["price"] as? Double,
                            let categoryRaw = itemData["category"] as? String,
                            let category = CategoryType(rawValue: categoryRaw)
                        else { return nil }
                        
                        return FoodItems(
                            id: id,
                            name: name,
                            image: image,
                            price: price,
                            category: category
                        )
                    }
                    
                    let order = Order(
                        id: doc.documentID,
                        items: items,
                        total: total,
                        createdAt: timestamp.dateValue(),
                        status: status
                    )
                    
                    fetchedOrders.append(order)
                }
                
                DispatchQueue.main.async {
                    self.activeOrders = fetchedOrders.filter { $0.status == .preparing }
                    self.historyOrders = fetchedOrders.filter { $0.status != .preparing }
                    
                    self.startAutoCheck()
                }
            }
    }
    
    // MARK: - Place Order
    
    func placeOrder(items: [FoodItems], total: Double) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let orderData: [String: Any] = [
            "total": total,
            "createdAt": Timestamp(date: Date()),
            "status": OrderStatus.preparing.rawValue,
            "items": items.map {
                [
                    "id": $0.id,
                    "name": $0.name,
                    "image": $0.image,
                    "price": $0.price,
                    "category": $0.category.rawValue
                ]
            }
        ]
        
        db.collection("users")
            .document(uid)
            .collection("orders")
            .addDocument(data: orderData)
    }
    
    // MARK: - Cancel Order
    
    func cancelOrder(_ order: Order) {
        updateStatus(order, status: .cancelled)
    }
    
    // MARK: - Complete Order
    
    func completeOrder(_ order: Order) {
        updateStatus(order, status: .delivered)
    }
    
    private func updateStatus(_ order: Order, status: OrderStatus) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users")
            .document(uid)
            .collection("orders")
            .document(order.id)
            .updateData([
                "status": status.rawValue
            ])
    }
    
    

    // MARK: - Auto Delivery System

    func startAutoCheck() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 60,
                                     repeats: true) { [weak self] _ in
            self?.checkOrders()
        }
    }

    private func checkOrders() {
        
        let now = Date()
        
        for order in activeOrders {
            
            let elapsed = now.timeIntervalSince(order.createdAt)
            
            if elapsed > 1800 {   // 30 minutes
                completeOrder(order)
            }
        }
    }
}
