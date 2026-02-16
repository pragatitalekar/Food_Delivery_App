//
//  OrdersView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import SwiftUI

struct OrdersView: View {
    
    @EnvironmentObject var orders: OrderManager
    
    var body: some View {
        List {
            if orders.activeOrders.isEmpty {
                Text("No Active Orders")
                    .foregroundColor(.gray)
            }
            
            ForEach(orders.activeOrders) { order in
                VStack(alignment: .leading, spacing: 10) {
                    
                    HStack {
                        Text("Order #\(order.id.prefix(5))")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("₹\(order.total, specifier: "%.0f")")
                            .foregroundColor(.orange)
                            .bold()
                    }
                    
                    Text("Preparing...")
                        .foregroundColor(.blue)
                    
                    Button("Cancel Order") {
                        orders.cancelOrder(order)
                    }
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.1))
                    .foregroundColor(.red)
                    .cornerRadius(10)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .shadow(radius: 3)
                .padding(.vertical, 6)
            }
        }
        .navigationTitle("Active Orders")
    }
}
