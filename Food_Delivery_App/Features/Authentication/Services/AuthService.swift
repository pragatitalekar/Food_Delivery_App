//
//  AuthService.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import FirebaseAuth
import FirebaseFirestore
import Combine

final class AuthService {

    static let shared = AuthService()
    private init() {}

    func signup(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error)
                return
            }

            guard let uid = result?.user.uid else { return }

            let userData: [String: Any] = [
                "email": email,
                "name": "",
                "phone": "",
                "address": "",
                "createdAt": Timestamp(),
                "isActive": true
            ]

            Firestore.firestore()
                .collection("users")
                .document(uid)
                .setData(userData) { error in
                    completion(error)
                }
        }
    }
}
