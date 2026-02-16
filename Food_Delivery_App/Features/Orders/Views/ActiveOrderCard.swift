//
//  ActiveOrderCard.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/15/26.
//
import SwiftUI

struct ActiveOrderCard: View {
    
    var order: Order
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Text("Order #\(order.id.prefix(5))")
                    .font(.headline)
                
                Spacer()
                
                Text("₹\(order.total, specifier: "%.0f")")
                    .foregroundColor(.orange)
                    .bold()
            }
            
            Text("Preparing your food 🍔")
                .foregroundColor(.blue)
            
            ProgressView(value: 0.6)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
}
