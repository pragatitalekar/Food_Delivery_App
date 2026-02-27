import SwiftUI
import FirebaseAuth

struct RootView: View {

    @State private var showSplash = true
    @State private var showAuth = false

    var body: some View {

        Group {

            if showSplash {
                SplashView {
                    handleGetStarted()
                }

            } else if showAuth {
                AuthView {
                    showAuth = false
                }

            } else {
                MainTabView()
            }
        }
    }

    private func handleGetStarted() {

        if Auth.auth().currentUser == nil {
            showAuth = true
        }

        showSplash = false
    }
}
