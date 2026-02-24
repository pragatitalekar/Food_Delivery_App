import SwiftUI
import Combine
import FirebaseAuth

struct LoginView: View {

    var onLoginSuccess: (() -> Void)?
    @Environment(\.dismiss) var dismiss

    @StateObject private var vm = AuthViewModel()
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    @State private var showPassword: Bool = false
    @State private var showReactivateAlert = false

    var body: some View {
        VStack(spacing: 30) {

            floatingField(title: "Email address", text: $vm.email)

            VStack(alignment: .leading, spacing: 10) {

                Text("Password")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)

                HStack {
                    if showPassword {
                        TextField("", text: $vm.password)
                            .font(.system(size: 18))
                            .autocapitalization(.none)
                    } else {
                        SecureField("", text: $vm.password)
                            .font(.system(size: 18))
                    }

                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }

                Divider()
                    .frame(height: 1.2)
                    .background(AppColors.divider)
            }

            HStack {
                Spacer()
                Button {
                    vm.resetPassword()
                } label: {
                    Text("Forgot password?")
                        .foregroundColor(AppColors.primary)
                        .font(.footnote)
                }
            }

            
            if !vm.errorMessage.isEmpty && vm.errorMessage != "ACCOUNT_DEACTIVATED" {
                Text(vm.errorMessage)
                    .foregroundColor(AppColors.error)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Button {
                vm.login { success in
                    if success {
                        onLoginSuccess?()
                        dismiss()
                    } else if vm.errorMessage == "ACCOUNT_DEACTIVATED" {
                        showReactivateAlert = true
                    }
                }
            } label: {
                Text("Login")
                    .foregroundColor(AppColors.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        isFormValid
                        ? AppColors.primary
                        : AppColors.primary.opacity(0.5)
                    )
                    .cornerRadius(30)
            }
            .disabled(!isFormValid)
            .padding(.top, 10)
        }
        .padding(.horizontal, 30)
        .padding(.top, 40)
        .padding(.bottom, 30)
        .alert("Account Deactivated", isPresented: $showReactivateAlert) {
            
            Button("Cancel", role: .cancel) {
                try? Auth.auth().signOut()
            }
            
            Button("Reactivate") {
                vm.reactivateAccount { success in
                    if success {
                        onLoginSuccess?()
                        dismiss()
                    }
                }
            }
            
        } message: {
            Text("Your account is currently deactivated. Would you like to reactivate it?")
        }
    }

    private func floatingField(
        title: String,
        text: Binding<String>
    ) -> some View {

        VStack(alignment: .leading, spacing: 10) {

            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColors.textSecondary)

            TextField("", text: text)
                .font(.system(size: 18))
                .autocapitalization(.none)

            Divider()
                .frame(height: 1.2)
                .background(AppColors.divider)
        }
    }

    private var isFormValid: Bool {
        !vm.email.isEmpty && !vm.password.isEmpty
    }
}

#Preview {
    LoginView()
}
