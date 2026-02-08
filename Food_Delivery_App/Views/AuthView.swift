//
//  AuthView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/7/26.
//

import SwiftUI

struct AuthView: View {

    @State private var selectedTab: AuthTab = .login

    var body: some View {
        VStack {

            Spacer()

            
            Image("logo")
                .resizable()
                .frame(width: 60, height: 60)

        
            HStack {
                tabButton(title: "Login", tab: .login)
                tabButton(title: "Sign-up", tab: .signup)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .padding()


            ZStack {
                if selectedTab == .login {
                    LoginView()
                        .transition(.move(edge: .leading))
                } else {
                    SignupView()
                        .transition(.move(edge: .trailing))
                }
            }
            .animation(.easeInOut, value: selectedTab)

            Spacer()
        }
        .background(Color(.systemGroupedBackground))
    }

    func tabButton(title: String, tab: AuthTab) -> some View {
        Button {
            selectedTab = tab
        } label: {
            Text(title)
                .fontWeight(selectedTab == tab ? .bold : .regular)
                .foregroundColor(selectedTab == tab ? .orange : .black)
                .frame(maxWidth: .infinity)
        }
    }
}

enum AuthTab {
    case login, signup
}
