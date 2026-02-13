//
//  PaymentMethod.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/12/26.
//


import Foundation

struct PaymentMethod: Identifiable, Codable {
    
    var id: String
    let type: String
    let holderName: String
    let number: String
    var expiryDate: String?
    var cvv: String?
    var ifsc: String?
}
