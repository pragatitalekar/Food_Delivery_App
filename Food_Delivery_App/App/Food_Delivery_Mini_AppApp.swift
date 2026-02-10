//
//  Food_Delivery_Mini_AppApp.swift
//  
//
//  Created by rentamac on 2/3/26.
//

import SwiftUI

@main
struct Food_Delivery_Mini_AppApp: App {
    
    @StateObject var navigationManager = NavigationManager.shared
    @StateObject var cartManager = CartManager()   // GLOBAL CART
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(navigationManager)
                .environmentObject(cartManager)   // INJECT HERE
        }
    }
}




