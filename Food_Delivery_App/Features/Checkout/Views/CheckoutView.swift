//
//  CheckoutView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import SwiftUI

struct CheckoutView: View {

    let onCancel: () -> Void
    let onProceed: () -> Void

    var body: some View {
        VStack(spacing: 20) {

            Text("Please note")
                .font(.headline)

            VStack(spacing: 12) {
                noteRow(
                    title: "DELIVERY TO MAINLAND",
                    price: "1000 - 2000"
                )

                Divider()

                noteRow(
                    title: "DELIVERY TO ISLAND",
                    price: "1000 - 3000"
                )
            }

            HStack(spacing: 16) {

                Button("Cancel") {
                    onCancel()
                }
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity)

                Button("Proceed") {
                    onProceed()
                }
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(24)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(28)
        .padding(.horizontal, 24)
        .padding(.bottom, 30)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }

    private func noteRow(title: String, price: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)

            Text(price)
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
}
