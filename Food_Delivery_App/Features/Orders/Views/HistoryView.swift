//
//  HistoryView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/12/26.
//

import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject var orders: OrderManager

    var body: some View {
        List {
            if orders.historyOrders.isEmpty {
                Text("No Past Orders")
                    .foregroundColor(.gray)
            }

            ForEach(orders.historyOrders) { order in
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text("Order #\(order.id.prefix(5))")
                        .font(.headline)
                    
                    Text("Items: \(order.items.count)")
                    
                    Text("Total ₹\(order.total, specifier: "%.0f")")
                        .foregroundColor(.green)
                    
                    Text("Delivered")
                        .foregroundColor(.green)
                    
                    Text(order.status.rawValue.capitalized)
                        .foregroundColor(order.status == .cancelled ? .red : .green)
                }
                .padding(.vertical, 6)
            }
        }
        .navigationTitle("Order History")
    }
}

