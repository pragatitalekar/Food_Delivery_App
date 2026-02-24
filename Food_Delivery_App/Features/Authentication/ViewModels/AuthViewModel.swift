
//
//  AuthViewModel.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//


import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore

final class AuthViewModel: ObservableObject {

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""

    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    func login(completion: @escaping (Bool) -> Void) {

        errorMessage = ""

        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and Password cannot be empty"
            completion(false)
            return
        }

        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email address"
            completion(false)
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { _, error in

            DispatchQueue.main.async {

                if let error = error as NSError? {

                    switch AuthErrorCode(rawValue: error.code) {

                    case .wrongPassword:
                        self.errorMessage = "Incorrect password"

                    case .userNotFound:
                        self.errorMessage = "Account does not exist. Please sign up."

                    case .invalidEmail:
                        self.errorMessage = "Invalid email format"

                    case .invalidCredential:
                        self.errorMessage = "Incorrect email or password"

                    case .networkError:
                        self.errorMessage = "Network error. Please try again."

                    default:
                        self.errorMessage = "Login failed. Please try again."
                    }

                    completion(false)
                    return
                }

                guard let uid = Auth.auth().currentUser?.uid else {
                    self.errorMessage = "User not found"
                    completion(false)
                    return
                }

                Firestore.firestore()
                    .collection("users")
                    .document(uid)
                    .getDocument { snapshot, _ in

                        DispatchQueue.main.async {

                            if let isActive = snapshot?.data()?["isActive"] as? Bool,
                               isActive == false {

                                self.errorMessage = "ACCOUNT_DEACTIVATED"
                                completion(false)
                                return
                            }

                            self.errorMessage = ""
                            self.isLoggedIn = true
                            completion(true)
                        }
                    }
            }
        }
    }
    
    func reactivateAccount(completion: @escaping (Bool) -> Void) {
        
        guard let user = Auth.auth().currentUser else {
            completion(false)
            return
        }
        
        Firestore.firestore()
            .collection("users")
            .document(user.uid)
            .updateData(["isActive": true]) { error in
                
                DispatchQueue.main.async {
                    if error == nil {
                        self.isLoggedIn = true
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
    }


    
    func resetPassword() {
           guard !email.isEmpty else {
               errorMessage = "Please enter your email first"
               return
           }

           Auth.auth().sendPasswordReset(withEmail: email) { error in
               if let error = error {
                   self.errorMessage = error.localizedDescription
               } else {
                   self.errorMessage = "Password reset email sent"
               }
           }
       }

    func signup(completion: @escaping (Bool) -> Void) {

        errorMessage = ""

        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and Password cannot be empty"
            completion(false)
            return
        }

        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email address"
            completion(false)
            return
        }

        if let passwordError = passwordValidationError(password) {
            errorMessage = passwordError
            completion(false)
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { _, error in

            DispatchQueue.main.async {

                if let error = error as NSError? {

                    switch AuthErrorCode(rawValue: error.code) {

                    case .emailAlreadyInUse:
                        self.errorMessage = "Email already registered. Please login."

                    case .invalidEmail:
                        self.errorMessage = "Invalid email format"

                    case .weakPassword:
                        self.errorMessage = "Password is too weak"

                    default:
                        self.errorMessage = "Signup failed. Please try again."
                    }

                    completion(false)
                    return
                }

                self.errorMessage = ""
                self.isLoggedIn = true
                completion(true)
            }
        }
    }
    

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex =
        "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex)
            .evaluate(with: email)
    }


    private func passwordValidationError(_ password: String) -> String? {
        
        if password.count < 9 {
            return "Password must be at least 9 characters long"
        }
        
        let specialCharacterRegex = ".*[!@#$%^&*(),.?\":{}|<>].*"
        if !NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex)
            .evaluate(with: password) {
            return "Password must contain at least one special character (!@#$...)"
        }
        
        let numberRegex = ".*[0-9].*"
        if !NSPredicate(format: "SELF MATCHES %@", numberRegex)
            .evaluate(with: password) {
            return "Password must contain at least one number"
        }
        
        return nil
    }
}

