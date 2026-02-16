//
//  EditAddressView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/11/26.
//


import SwiftUI
import FirebaseFirestore
import FirebaseAuth


struct EditAddressView: View {

    @Environment(\.dismiss) private var dismiss

    let address: UserAddress

    @State private var name: String
    @State private var fullName: String
    @State private var phone: String
    @State private var street: String

    var onSave: () -> Void


    init(address: UserAddress, onSave: @escaping () -> Void) {

        self.address = address
        self.onSave = onSave

        _name = State(initialValue: address.name)
        _fullName = State(initialValue: address.fullName)
        _phone = State(initialValue: address.phone)
        _street = State(initialValue: address.street)
    }


    var body: some View {

        NavigationStack {

            Form {

                TextField("Address Name", text: $name)

                TextField("Full Name", text: $fullName)

                TextField("Phone", text: $phone)

                TextField("Street", text: $street)
            }
            .navigationTitle("Edit Address")
            .toolbar {

                ToolbarItem(placement: .confirmationAction) {

                    Button("Save") {

                        updateAddress()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {

                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }


    private func updateAddress() {

        guard let id = address.id else { return }

        let updatedData: [String: Any] = [

            "name": name,
            "fullName": fullName,
            "phone": phone,
            "street": street
        ]

        let uid = Auth.auth().currentUser?.uid ?? ""

        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("addresses")
            .document(id)
            .updateData(updatedData) { _ in

                onSave()
                dismiss()
            }
    }
}

