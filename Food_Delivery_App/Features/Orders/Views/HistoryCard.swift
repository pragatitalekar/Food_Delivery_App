//
//  HistoryCard.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/20/26.
//

import SwiftUI

struct HistoryCard: View {
    
    let order: Order
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 14) {
            
      
            HStack {
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text("Order #\(order.id.prefix(5))")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Text(formatDate(order.createdAt))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text("₹\(order.total, specifier: "%.0f")")
                    .font(.headline)
                    .foregroundColor(.green)
            }
            
            Divider()
            
            Text("\(order.items.count) items")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack {
                Text(order.status.rawValue.capitalized)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(statusColor.opacity(0.15))
                    .foregroundColor(statusColor)
                    .cornerRadius(20)
                
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 6)
    }
    
    var statusColor: Color {
        switch order.status {
        case .cancelled:
            return .red
        case .preparing:
            return .orange
        case .delivered:
            return .green
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
