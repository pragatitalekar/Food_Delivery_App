import SwiftUI

struct SignupView: View {

    @StateObject private var vm = AuthViewModel()

    var body: some View {
        VStack(spacing: 24) {

            floatingField(title: "Email address", text: $vm.email)

            floatingField(title: "Password", text: $vm.password, secure: true)

            Button {
                vm.signup()
            } label: {
                Text("Create Account")
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
                destination: HomeView(),
                isActive: $vm.isLoggedIn
            ) { EmptyView() }
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 30)
    }

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
