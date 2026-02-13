//
//  ProfileViewModel.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import SwiftUI
import FirebaseAuth
import Combine

final class ProfileViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var address = ""
    
    @Published var isLoading = false
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    private let service = ProfileService.shared
    
    
    init() {
        loadProfile()
    }
    
    
    // MARK: Load Profile
    
    func loadProfile() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No UID")
            return
        }
        
        email = Auth.auth().currentUser?.email ?? ""
        
        service.fetchProfile(uid: uid) { result in
            
            DispatchQueue.main.async {
                
                switch result {
                    
                case .success(let data):
                    
                    self.name = data["name"] as? String ?? ""
                    self.phone = data["phone"] as? String ?? ""
                    self.address = data["address"] as? String ?? ""
                    
                    
                case .failure(let error):
                    
                    print("FETCH ERROR:", error.localizedDescription)
                }
            }
        }
    }
    
    
    // MARK: Save Profile
    
    func saveProfile() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        isLoading = true
        
        let data: [String: Any] = [
            
            "name": name,
            "email": email,
            "phone": phone,
            "address": address,
            "updatedAt": Date()
        ]
        
        
        service.updateProfile(uid: uid, data: data) { result in
            
            DispatchQueue.main.async {
                
                self.isLoading = false
                
                switch result {
                    
                case .success:
                    
                    self.alertMessage = "Profile updated successfully"
                    self.showAlert = true
                    
                    
                case .failure(let error):
                    
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                }
            }
        }
    }
}

