import SwiftUI

enum AuthTab {
    case login, signup
}

struct AuthView: View {

    @State private var selectedTab: AuthTab = .login

    var body: some View {
        VStack {

            Spacer()

            HStack {
                tabButton("Login", .login)
                tabButton("Sign up", .signup)
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

    private func tabButton(_ title: String, _ tab: AuthTab) -> some View {
        Button {
            selectedTab = tab
        } label: {
            Text(title)
                .fontWeight(selectedTab == tab ? .bold : .regular)
                .foregroundColor(selectedTab == tab ? .orange : .gray)
                .frame(maxWidth: .infinity)
        }
    }
}
