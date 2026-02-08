import SwiftUI
import Combine
import FirebaseAuth

final class AuthViewModel: ObservableObject {

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    self.isLoggedIn = true
                }
            }
        }
    }

    func signup() {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    self.isLoggedIn = true
                }
            }
        }
    }
}
