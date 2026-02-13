//
//  AddressViewModel.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/12/26.
//


import SwiftUI
import Combine

final class AddressViewModel: ObservableObject {

    @Published var addresses: [UserAddress] = []

    private let service = AddressService.shared


    init() {
        load()
    }


    func load() {

        service.fetchAddresses { result in

            DispatchQueue.main.async {

                if case .success(let data) = result {
                    self.addresses = data
                }
            }
        }
    }


    func delete(id: String) {

        service.deleteAddress(id: id) { _ in

            DispatchQueue.main.async {
                self.load()
            }
        }
    }


    func setDefault(id: String) {

        service.setDefaultAddress(id: id) { _ in

            DispatchQueue.main.async {
                self.load()
            }
        }
    }
}
