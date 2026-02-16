import SwiftUI

struct AddAddressView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var fullName = ""
    @State private var phone = ""
    @State private var street = ""

    var onSave: () -> Void


    var body: some View {

        NavigationStack {

            Form {

                Section("Address Info") {

                    TextField("Address Name (Home, Office)", text: $name)

                    TextField("Full Name", text: $fullName)

                    TextField("Phone Number", text: $phone)
                        .keyboardType(.phonePad)

                    TextField("Street Address", text: $street)
                }
            }
            .navigationTitle("Add Address")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(placement: .confirmationAction) {

                    Button("Save") {

                        let address = UserAddress(
                            name: name,
                            fullName: fullName,
                            phone: phone,
                            street: street,
                            isDefault: false,
                            createdAt: Date()
                        )

                        AddressService.shared.addAddress(address) { result in

                            DispatchQueue.main.async {

                                onSave()
                                dismiss()
                            }
                        }
                    }
                    .disabled(
                        name.isEmpty ||
                        fullName.isEmpty ||
                        phone.isEmpty ||
                        street.isEmpty
                    )
                }


                ToolbarItem(placement: .cancellationAction) {

                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
