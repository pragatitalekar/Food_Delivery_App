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
                VStack(alignment: .leading, spacing: 8) {
                    
                    HStack {
                        Text("Order #\(order.id.prefix(5))")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("₹\(order.total, specifier: "%.0f")")
                            .foregroundColor(.green)
                            .bold()
                    }
                    
                    Text("Items: \(order.items.count)")
                        .foregroundColor(.gray)
                    
                    Text(order.status.rawValue.capitalized)
                        .foregroundColor(order.status == .cancelled ? .red : .green)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .shadow(radius: 3)
                .padding(.vertical, 6)
            }
        }
        .navigationTitle("Order History")
    }
}
