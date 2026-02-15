//
//  AddressRow.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/12/26.
//


import SwiftUI

struct AddressRow: View {

    let address: UserAddress

    var onSelect: () -> Void
    var onDelete: () -> Void


    var body: some View {

        HStack {

            Button(action: onSelect) {

                Image(systemName:
                        address.isDefault
                      ? "largecircle.fill.circle"
                      : "circle")
                .foregroundColor(.orange)
            }


            VStack(alignment: .leading) {

                Text(address.name)
                    .font(.headline)

                Text(address.street)
                    .font(.footnote)

                Text(address.phone)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }


            Spacer()


            Button(role: .destructive, action: onDelete) {
                Image(systemName: "trash")
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}
