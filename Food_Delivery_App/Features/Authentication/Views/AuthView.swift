//
//  AuthView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/10/26.
//

import SwiftUI

struct AuthView: View {

    @State private var selectedTab: Tab = .login

    enum Tab {
        case login, signup
    }

    var body: some View {
        ZStack {
            Color.lightBackground.ignoresSafeArea()

            VStack {
                Spacer()

                
                VStack(spacing: 20) {

                    
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .padding(.top, 25)

                
                    HStack (spacing: 80){
                        tabItem(title: "Login", tab: .login)
                        
                        tabItem(title: "Sign-up", tab: .signup)
                    }
                    .padding(.horizontal, 50)

                
                    if selectedTab == .login {
                        LoginView()
                    } else {
                        SignupView()
                    }
                }
                .background(Color.white)
                .cornerRadius(30)
                .padding(.horizontal, 20)
                .shadow(color: .black.opacity(0.1), radius: 10)

                Spacer()
            }
        }
    }

    
    private func tabItem(title: String, tab: Tab) -> some View {
        VStack(spacing: 6) {
            Button {
                withAnimation {
                    selectedTab = tab
                }
            } label: {
                Text(title)
                    .foregroundColor(.black)
                    .font(.headline)
            }

            Rectangle()
                .fill(selectedTab == tab ? Color.primaryOrange : Color.clear)
                .frame(width: 50, height: 3)
        }
    }
}
