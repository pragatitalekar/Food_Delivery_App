import SwiftUI
import Combine

struct SignupView: View {

    @StateObject private var vm = AuthViewModel()

    var body: some View {
        VStack(spacing: 40) {

            floatingField(title: "Email address", text: $vm.email)

            floatingField(title: "Password", text: $vm.password, secure: true)
            
            HStack {
                Spacer()
                Text(" ")
                    .font(.footnote)
            }
            .frame(height: 5)

            Button {
                vm.signup()
            } label: {
                Text("Create Account")
                    .foregroundColor(AppColors.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppColors.primary)
                    .cornerRadius(30)
            }
            .padding(.top, 10)

            if !vm.errorMessage.isEmpty {
                Text(vm.errorMessage)
                    .foregroundColor(AppColors.error)
            }

            NavigationLink(
                destination: MainTabView(),
                isActive: $vm.isLoggedIn
            ) {
                EmptyView()
            }
        }
        .padding(.horizontal, 30)
        .padding(.top, 40)     // added spacing from top white card
        .padding(.bottom, 30)
    }

    private func floatingField(
        title: String,
        text: Binding<String>,
        secure: Bool = false
    ) -> some View {

        VStack(alignment: .leading, spacing: 10) {

            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.gray)   // matches your design

            if secure {
                SecureField("", text: text)
                    .font(.system(size: 18))
            } else {
                TextField("", text: text)
                    .font(.system(size: 18))
                    .autocapitalization(.none)
            }

            Divider()
                .frame(height: 1.2)
                .background(Color.gray.opacity(0.4))
        }
    }
}
