import SwiftUI

struct LoginView: View {

    @StateObject private var vm = AuthViewModel()

    var body: some View {
        VStack(spacing: 20) {

            TextField("Email address", text: $vm.email)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $vm.password)
                .textFieldStyle(.roundedBorder)

            Button("Login") {
                vm.login()
            }

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
