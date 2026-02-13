//
//  PaymentViewModel.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/12/26.
//


import SwiftUI
import FirebaseAuth
import Combine

final class PaymentViewModel: ObservableObject {
    @Published var methods: [PaymentMethod] = []
    @Published var selectedType = "Card"
    @Published var isLoading = false
    
    private let service = PaymentService.shared
    
    func load(completion: (() -> Void)? = nil) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        isLoading = true
        
        service.fetchMethods(uid: uid) { result in
            
            DispatchQueue.main.async {
                
                self.isLoading = false
                
                if case .success(let data) = result {
                    self.methods = data
                    completion?()
                }
            }
        }
    }

    
    func delete(id: String) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        service.deleteMethod(uid: uid, id: id) { _ in
            
            DispatchQueue.main.async {
                self.load()
            }
        }
    }

}
