//
//  Food_Delivery_Mini_AppApp.swift
//  
//
//  Created by rentamac on 2/3/26.
//

import SwiftUI
import FirebaseCore

@main
struct Food_Delivery_Mini_AppApp: App {
    
    @StateObject var cartManager = CartManager()
    @StateObject var Orders = OrderManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            
            RootView()
                .environmentObject(cartManager)
                .environmentObject(Orders)
        }
    }
}

