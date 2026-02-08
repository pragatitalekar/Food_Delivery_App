//
//  SignupView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/7/26.
//

import SwiftUI

struct SignupView: View {

    @StateObject private var vm = AuthViewModel()

    var body: some View {
        VStack(spacing: 20) {

            TextField("Email address", text: $vm.email)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $vm.password)
                .textFieldStyle(.roundedBorder)

            Button("Create Account") {
                vm.signup()
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)

            if !vm.errorMessage.isEmpty {
                Text(vm.errorMessage)
                    .foregroundColor(.red)
            }

            NavigationLink(
                destination: HomeView(),
                isActive: $vm.isLoggedIn
            ) { EmptyView() }
        }
        .padding()
    }
}
