//
//  Address.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import Foundation

struct UserAddress: Identifiable {

    var id: String?

    var name: String
    var fullName: String
    var phone: String
    var street: String

    var isDefault: Bool
    var createdAt: Date


    init(
        id: String? = nil,
        name: String,
        fullName: String,
        phone: String,
        street: String,
        isDefault: Bool = false,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.phone = phone
        self.street = street
        self.isDefault = isDefault
        self.createdAt = createdAt
    }
}
