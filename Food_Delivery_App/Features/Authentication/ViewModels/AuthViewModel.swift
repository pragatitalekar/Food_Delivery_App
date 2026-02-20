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
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    completion(false)
                } else {
                    self.errorMessage = ""
                    self.isLoggedIn = true
                    completion(true)   // ⭐ IMPORTANT
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
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    completion(false)
                } else {
                    self.errorMessage = ""
                    self.isLoggedIn = true
                    completion(true)   // ⭐ IMPORTANT
                }
            }
        }
    }
}
