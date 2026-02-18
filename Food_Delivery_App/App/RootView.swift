//
//  RootView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/18/26.
//

import SwiftUI
import FirebaseAuth

struct RootView: View {
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    var body: some View {
        
        Group {
            if isLoggedIn {
                MainTabView()
            } else {
                SplashView()
            }
        }
        .onAppear {
            checkLoginState()
        }
    }
    
    private func checkLoginState() {
        if Auth.auth().currentUser != nil {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }
}
