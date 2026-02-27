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
        
        listener?.remove() 
        
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
                    
                    var review: Review? = nil

                    if let reviewData = data["review"] as? [String: Any],
                        let rating = reviewData["rating"] as? Int,
                        let comment = reviewData["comment"] as? String,
                        let reviewTimestamp = reviewData["createdAt"] as? Timestamp {

                        review = Review(
                            rating: rating,
                            comment: comment,
                            createdAt: reviewTimestamp.dateValue()
                        )
                    }
                    
                    let order = Order(
                        id: doc.documentID,
                        items: items,
                        total: total,
                        createdAt: timestamp.dateValue(),
                        status: status,
                        review: review
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
    
    
    
    func cancelOrder(_ order: Order) {
        updateStatus(order, status: .cancelled)
    }
    
    
    
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
    
    


    func startAutoCheck() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 5,
                                     repeats: true) { [weak self] _ in
            self?.checkOrders()
        }
    }

    private func checkOrders() {
        
        let now = Date()
        
        for order in activeOrders {
            
            let elapsed = now.timeIntervalSince(order.createdAt)
            
            if elapsed > 600 {   // 30 minutes
                completeOrder(order)
            }
        }
    }
    
    
    func submitReview(for order: Order,
                      rating: Int,
                      comment: String) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let reviewData: [String: Any] = [
            "rating": rating,
            "comment": comment,
            "createdAt": Timestamp(date: Date())
        ]
        
        db.collection("users")
            .document(uid)
            .collection("orders")
            .document(order.id)
            .updateData([
                "review": reviewData
            ])
    }
}
