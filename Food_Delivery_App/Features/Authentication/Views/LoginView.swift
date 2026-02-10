//
//  LoginView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import SwiftUI

struct LoginView: View {

    @StateObject private var vm = AuthViewModel()

    var body: some View {
        VStack(spacing: 24) {

            floatingField(title: "Email address", text: $vm.email)

            floatingField(title: "Password", text: $vm.password, secure: true)

            HStack {
                Spacer()
                Button {
                    vm.resetPassword()
                } label: {
                    Text("Forgot passcode?")
                        .foregroundColor(Color("#FF4B3A"))
                        .font(.footnote)
                }

            }

            Button {
                vm.login()
            } label: {
                Text("Login")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.primaryOrange)
                    .cornerRadius(30)
            }
            .padding(.top, 10)

            if !vm.errorMessage.isEmpty {
                Text(vm.errorMessage)
                    .foregroundColor(.red)
            }

            NavigationLink(
                destination: MainTabView(),
                isActive: $vm.isLoggedIn
            ) { EmptyView() }
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 30)
    }

    // MARK: - Floating Field
    private func floatingField(
        title: String,
        text: Binding<String>,
        secure: Bool = false
    ) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)

            if secure {
                SecureField("", text: text)
            } else {
                TextField("", text: text)
                    .autocapitalization(.none)
            }

            Divider()
        }
    }
}
