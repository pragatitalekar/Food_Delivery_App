import SwiftUI
import FirebaseAuth

struct RootView: View {

    @State private var showSplash = true
    @State private var showStartupAuth = false

    var body: some View {
        Group {
            if showSplash {
                SplashView()

            } else if showStartupAuth {
                AuthView {
                    showStartupAuth = false   // ⭐ after first login
                }

            } else {
                MainTabView()   // ⭐ Root never depends on isLoggedIn
            }
        }
        .onAppear {
            startAppFlow()
        }
    }

    private func startAppFlow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showStartupAuth = Auth.auth().currentUser == nil
            showSplash = false
        }
    }
}
