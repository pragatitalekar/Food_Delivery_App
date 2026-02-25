import SwiftUI
import Combine

struct AuthView: View {

    @State private var selectedTab: Tab = .login

    var onLoginSuccess: (() -> Void)? = nil

    enum Tab {
        case login, signup
    }

    var body: some View {
        ZStack {

            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {

                VStack(spacing: 0) {

                    Image("AppLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding(.top, 100)

                    Spacer()

                    HStack {
                        Spacer()
                        tabItem(title: "Login", tab: .login)
                        Spacer()
                        tabItem(title: "Sign-up", tab: .signup)
                        Spacer()
                    }
                    .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 380)
                .background(Color(uiColor: .systemBackground))
                .clipShape(
                    RoundedCorner(radius: 40, corners: [.bottomLeft, .bottomRight])
                )
                .ignoresSafeArea(edges: .top)

                if selectedTab == .login {
                    LoginView(onLoginSuccess: onLoginSuccess)
                } else {
                    SignupView(onLoginSuccess: onLoginSuccess)
                }


                Spacer()
            }
        }
    }

    private func tabItem(title: String, tab: Tab) -> some View {
        VStack(spacing: 6) {
            Button {
                withAnimation {
                    selectedTab = tab
                }
            } label: {
                Text(title)
                    .foregroundColor(AppColors.textPrimary)
                    .font(.headline)
            }

            Rectangle()
                .fill(selectedTab == tab ? AppColors.primary : Color.clear)
                .frame(width: 50, height: 3)
        }
    }
}

