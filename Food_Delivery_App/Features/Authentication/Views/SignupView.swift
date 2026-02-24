import SwiftUI
import Combine

struct SignupView: View {

    var onLoginSuccess: (() -> Void)?

    @StateObject private var vm = AuthViewModel()
    @State private var confirmPassword: String = ""
    @State private var showPassword: Bool = false
    @State private var showConfirmPassword: Bool = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

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

            VStack(alignment: .leading, spacing: 10) {

                Text("Confirm Password")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)

                HStack {
                    if showConfirmPassword {
                        TextField("", text: $confirmPassword)
                            .font(.system(size: 18))
                            .autocapitalization(.none)
                    } else {
                        SecureField("", text: $confirmPassword)
                            .font(.system(size: 18))
                    }

                    Button {
                        showConfirmPassword.toggle()
                    } label: {
                        Image(systemName: showConfirmPassword ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }

                Divider()
                    .frame(height: 1.2)
                    .background(AppColors.divider)
            }

            if !vm.errorMessage.isEmpty {
                Text(vm.errorMessage)
                    .foregroundColor(AppColors.error)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Button {
                if vm.password != confirmPassword {
                    vm.errorMessage = "Passwords do not match"
                    return
                }

                vm.signup { success in
                    if success {
                        isLoggedIn = true
                        onLoginSuccess?()
                    }
                }
            } label: {
                Text("Create Account")
                    .foregroundColor(AppColors.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        isFormFilled
                        ? AppColors.primary
                        : AppColors.primary.opacity(0.5)
                    )
                    .cornerRadius(30)
            }
            .disabled(!isFormFilled)
            .padding(.top, 10)
        }
        .padding(.horizontal, 30)
        .padding(.top, 40)
        .padding(.bottom, 30)
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

    private var isFormFilled: Bool {
        !vm.email.isEmpty && !vm.password.isEmpty && !confirmPassword.isEmpty
    }
}
