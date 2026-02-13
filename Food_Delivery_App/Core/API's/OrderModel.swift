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
    let id: String
    let items: [FoodItems]
    let total: Double
    let createdAt: Date
    var status: OrderStatus
}


