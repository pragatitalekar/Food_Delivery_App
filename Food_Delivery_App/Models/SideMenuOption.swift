//
//  SideMenuOption.swift
//  Food_Delivery_App
//
//  Created by Bhaswanth on 2/6/26.
//

import Foundation

enum SideMenuOption: String, CaseIterable, Hashable {
    case profile = "Profile"
    case orders = "orders"
    case offers = "offer and promo"
    case privacy = "Privacy policy"
    case security = "Security"
    
    var icon: String {
        switch self {
        case .profile: return "person.crop.circle.fill"
        case .orders: return "cart.fill"
        case .offers: return "tag.fill"
        case .privacy: return "doc.text.fill"
        case .security: return "shield.fill"
        }
    }
}

