//
//  AddressListView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/12/26.
//


import SwiftUI

struct AddressListView: View {

    @StateObject private var vm = AddressViewModel()

    @State private var showAdd = false


    var body: some View {

        ScrollView {

            VStack(spacing: 16) {

                ForEach(vm.addresses) { address in

                    AddressRow(
                        address: address,
                        onSelect: {
                            if let id = address.id {
                                vm.setDefault(id: id)
                            }
                        },
                        onDelete: {
                            if let id = address.id {
                                vm.delete(id: id)
                            }
                        }
                    )
                }


                Button("Add Address") {
                    showAdd = true
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(12)

            }
            .padding()
        }
        .navigationTitle("Addresses")
        .sheet(isPresented: $showAdd) {

            AddAddressView {
                vm.load()
            }
        }
    }
}
