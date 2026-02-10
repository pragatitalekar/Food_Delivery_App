//
//  CartView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/8/26.
//
import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var cart: CartManager
    
    var body: some View {
        
        VStack {
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    ForEach(cart.items) { item in
                        CartItemCard(item: item)
                       
                    }
                }
                .padding()
            }
            
            Divider()
            
            HStack {
                Text("Total")
                    .font(.headline)
                Spacer()
                Text("₹\(cart.total, specifier: "%.0f")")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
            }
            .padding()
        }
        .navigationTitle("Cart")
    }
}

#Preview {
    CartView()
        .environmentObject(CartManager())
}

