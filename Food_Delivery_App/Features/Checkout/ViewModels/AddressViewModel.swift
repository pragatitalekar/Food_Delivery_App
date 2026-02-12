//
//  AddressViewModel.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/11/26.
//

import Foundation
import SwiftUI
import Combine

class AddressViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var street: String = ""
    @Published var phone: String = ""
    
    init() {
        loadAddress()
    }
    
    func loadAddress() {
        if let saved = PersistenceService.shared.loadAddress() {
            name = saved.name
            street = saved.street
            phone = saved.phone
        }
    }
    
    func saveAddress() {
        let address = AddressModel(name: name,
                                   street: street,
                                   phone: phone)
        PersistenceService.shared.saveAddress(address)
    }
    
    var isEmpty: Bool {
        name.isEmpty && street.isEmpty && phone.isEmpty
    }
}
