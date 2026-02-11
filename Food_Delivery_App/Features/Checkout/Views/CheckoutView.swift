//
//  CheckoutView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import SwiftUI

struct CheckoutView: View {

    var onCancel: () -> Void
    var onProceed: () -> Void

    var body: some View {
        VStack(spacing: 20) {

            Text("Please note")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 12) {
                noteRow(title: "DELIVERY TO Encora", price: "1000 – 2000")
                
            }

            HStack {
                Button("Cancel") {
                    onCancel()
                }
                .foregroundColor(.gray)

                Spacer()

                Button {
                    onProceed()
                } label: {
                    Text("Proceed")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 28)
                        .padding(.vertical, 12)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 40)
    }

    private func noteRow(title: String, price: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)

            Text(price)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
