
//
//  AuthViewModel.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//


import SwiftUI
import Combine
import FirebaseAuth

final class AuthViewModel: ObservableObject {

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""

    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    func login(completion: @escaping (Bool) -> Void) {

        errorMessage = ""

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

                self.errorMessage = ""
                self.isLoggedIn = true
                completion(true)
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

        Auth.auth().createUser(withEmail: email, password: password) { _, error in

            DispatchQueue.main.async {

                if let error = error as NSError? {

                    switch AuthErrorCode(rawValue: error.code) {

                    case .emailAlreadyInUse:
                        self.errorMessage = "Email already registered. Please login."

                    case .invalidEmail:
                        self.errorMessage = "Invalid email format"

                    case .weakPassword:
                        self.errorMessage = "Password must be at least 6 characters"

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
}

