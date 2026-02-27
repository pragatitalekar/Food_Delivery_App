//
//  ChangePasswordView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/24/26.
//

import SwiftUI
import FirebaseAuth

struct ChangePasswordView: View {

    @Environment(\.dismiss) var dismiss

    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""

    @State private var showCurrent: Bool = false
    @State private var showNew: Bool = false
    @State private var showConfirm: Bool = false

    @State private var errorMessage: String = ""
    @State private var successMessage: String = ""

    var body: some View {
        VStack(spacing: 30) {

            passwordField(
                title: "Current Password",
                text: $currentPassword,
                isSecure: $showCurrent
            )

            passwordField(
                title: "New Password",
                text: $newPassword,
                isSecure: $showNew
            )

            passwordField(
                title: "Confirm New Password",
                text: $confirmPassword,
                isSecure: $showConfirm
            )

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }

            if !successMessage.isEmpty {
                Text(successMessage)
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)
            }

            Button {
                changePassword()
            } label: {
                Text("Update Password")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormValid ? Color.orange : Color.orange.opacity(0.5))
                    .cornerRadius(30)
            }
            .disabled(!isFormValid)

            Spacer()
        }
        .padding(30)
        .navigationTitle("Change Password")
    }

    private func passwordField(
        title: String,
        text: Binding<String>,
        isSecure: Binding<Bool>
    ) -> some View {

        VStack(alignment: .leading, spacing: 10) {

            Text(title)
                .font(.system(size: 16, weight: .medium))

            HStack {
                if isSecure.wrappedValue {
                    TextField("", text: text)
                } else {
                    SecureField("", text: text)
                }

                Button {
                    isSecure.wrappedValue.toggle()
                } label: {
                    Image(systemName: isSecure.wrappedValue ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }

            Divider()
        }
    }

    private var isFormValid: Bool {
        !currentPassword.isEmpty &&
        !newPassword.isEmpty &&
        !confirmPassword.isEmpty
    }

    private func changePassword() {

        errorMessage = ""
        successMessage = ""

        guard newPassword == confirmPassword else {
            errorMessage = "New passwords do not match"
            return
        }

        if let error = passwordValidationError(newPassword) {
            errorMessage = error
            return
        }

        guard let user = Auth.auth().currentUser,
              let email = user.email else {
            errorMessage = "User not found"
            return
        }

        let credential = EmailAuthProvider.credential(
            withEmail: email,
            password: currentPassword
        )

        user.reauthenticate(with: credential) { _, error in

            if let _ = error {
                errorMessage = "Current password is incorrect"
                return
            }

            user.updatePassword(to: newPassword) { error in

                if let _ = error {
                    errorMessage = "Failed to update password"
                } else {
                    successMessage = "Password updated successfully"
                    currentPassword = ""
                    newPassword = ""
                    confirmPassword = ""
                }
            }
        }
    }

    private func passwordValidationError(_ password: String) -> String? {
        
        if password.count < 9 {
            return "Password must be at least 9 characters long"
        }
        
        let uppercaseRegex = ".*[A-Z].*"
        if !NSPredicate(format: "SELF MATCHES %@", uppercaseRegex)
            .evaluate(with: password) {
            return "Password must contain at least one uppercase letter"
        }
        
        let lowercaseRegex = ".*[a-z].*"
        if !NSPredicate(format: "SELF MATCHES %@", lowercaseRegex)
            .evaluate(with: password) {
            return "Password must contain at least one lowercase letter"
        }
        
        let numberRegex = ".*[0-9].*"
        if !NSPredicate(format: "SELF MATCHES %@", numberRegex)
            .evaluate(with: password) {
            return "Password must contain at least one number"
        }
        
        let specialCharacterRegex = ".*[!@#$%^&*(),.?\":{}|<>].*"
        if !NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex)
            .evaluate(with: password) {
            return "Password must contain at least one special character"
        }
        
        return nil
    }
}
