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
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Order #\(order.id.prefix(5))")
                        .font(.headline)
                    
                    Text("Total ₹\(order.total, specifier: "%.0f")")
                        .foregroundColor(.orange)
                    
                    Text("Preparing...")
                        .foregroundColor(.blue)
                    
                    Button("Cancel Order") {
                        orders.cancelOrder(order)
                    }
                    .foregroundColor(.red)
                }
                .padding(.vertical, 6)
            }
        }
        .navigationTitle("Active Orders")
    }
}

