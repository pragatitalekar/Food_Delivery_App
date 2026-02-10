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
    
    @StateObject var navigationManager = NavigationManager.shared
    @StateObject var cartManager = CartManager()   // GLOBAL CART
    init() {
           FirebaseApp.configure()
       }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(navigationManager)
                .environmentObject(cartManager)   // INJECT HERE
        }
    }
}




