//
//  Order.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//
import Foundation

struct Order: Identifiable, Codable ,Equatable {
    
    var id: String
    var items: [FoodItems]
    var total: Double
    var createdAt: Date
    var status: OrderStatus
}

enum OrderStatus: String, Codable {
    case preparing
    case delivered
    case cancelled
}





