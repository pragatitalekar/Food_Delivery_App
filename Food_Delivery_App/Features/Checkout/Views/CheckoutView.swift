//
//  CheckoutView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//



import SwiftUI

struct CheckoutView: View {
    
    var address: String
    var deliveryType: String
    var paymentType: String
    
    var onCancel: () -> Void
    var onProceed: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Please note")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 12) {
                
                noteRow(
                    title: "DELIVERY TO",
                    price: address
                )

                
                Divider()
                
                noteRow(
                    title: "Payment Method",
                    price: paymentType.capitalized
                )
            }
            
            HStack {
                Button("Cancel") {
                    onCancel()
                }
                .foregroundColor(.secondary)

                
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
        .background(Color(.systemBackground))

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
                .foregroundColor(.primary)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
