//
//  Order.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//
import Foundation

enum OrderStatus: String, Codable {
    case preparing
    case delivered
    case cancelled
}

struct Order: Identifiable, Codable {
    var id: String
    var items: [FoodItems]
    var total: Double
    var createdAt: Date
    var status: OrderStatus
}




