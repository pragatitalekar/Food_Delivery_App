import SwiftUI
import FirebaseCore

@main
struct Food_Delivery_Mini_AppApp: App {

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
