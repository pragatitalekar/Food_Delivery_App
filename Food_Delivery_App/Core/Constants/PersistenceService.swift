//
//  PersistenceService.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/10/26.
//

import Foundation


struct AddressModel: Codable {
    var name: String
    var street: String
    var phone: String
}

class PersistenceService {
    
    static let shared = PersistenceService()
    private init() {}
    
    private let addressKey = "savedAddress"
    private let deliveryKey = "selectedDelivery"
    private let paymentKey = "selectedPayment"
    private let favouritesKey = "favourites"

    
    func saveFavourites(_ favourites: Set<String>) {
        UserDefaults.standard.set(Array(favourites), forKey: favouritesKey)
    }

  
    func loadFavourites() -> Set<String> {
        if let saved = UserDefaults.standard.array(forKey: favouritesKey) as? [String] {
            return Set(saved)
        }
        return []
    }
    

    
    func saveAddress(_ address: AddressModel) {
        if let encoded = try? JSONEncoder().encode(address) {
            UserDefaults.standard.set(encoded, forKey: addressKey)
        }
    }
    
    func loadAddress() -> AddressModel? {
        if let savedData = UserDefaults.standard.data(forKey: addressKey),
           let decoded = try? JSONDecoder().decode(AddressModel.self, from: savedData) {
            return decoded
        }
        return nil
    }
    
  
    
    func saveDelivery(_ value: String) {
        UserDefaults.standard.set(value, forKey: deliveryKey)
    }
    
    func loadDelivery() -> String {
        UserDefaults.standard.string(forKey: deliveryKey) ?? "door"
    }
    

    
    func savePayment(_ value: String) {
        UserDefaults.standard.set(value, forKey: paymentKey)
    }
    
    func loadPayment() -> String {
        UserDefaults.standard.string(forKey: paymentKey) ?? "card"
    }
}

