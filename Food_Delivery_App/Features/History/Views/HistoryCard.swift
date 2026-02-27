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
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text(formatDate(order.createdAt))
                        .font(.caption)
                        .foregroundColor(AppColors.textSecondary)
                }
                
                Spacer()
                
                Text("₹\(order.total, specifier: "%.0f")")
                    .font(.headline)
                    .foregroundColor(.green)
            }
            
            Divider()
            
            let groupedItems = Dictionary(grouping: order.items, by: { $0.id })

            ForEach(Array(groupedItems.keys), id: \.self) { key in

                if let items = groupedItems[key],
                    let item = items.first {

                        HStack(spacing: 12) {

                        
                        AsyncImage(url: URL(string: item.image)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())

                        
                        HStack(spacing: 8) {

                        Text("\(items.count)x")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.gray.opacity(0.15))
                            .cornerRadius(8)

                        Text(item.name)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .foregroundColor(AppColors.textPrimary)
                        }

                        Spacer()
                    }
                }
            }
            
            HStack {
                Text(order.status.rawValue.capitalized)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(statusColor.opacity(0.15))
                    .foregroundColor(statusColor)
                    .cornerRadius(20)
                    
                Spacer()
            }
            .padding(.vertical, 2)
            
            
            if order.status == .delivered {
                
                if let review = order.review {
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        HStack {
                            ForEach(0..<review.rating, id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                        
                        Text("\"\(review.comment)\"")
                            .font(.subheadline)
                            .padding(.vertical, 4)
                    }
                    .padding(.top, 8)
                   
                    
                } else {
                    ReviewInputView(order: order)
                }
            }
        }
        .padding()
        
        .background(AppColors.background)
        .cornerRadius(18)
        .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 4)
    }
    
    var statusColor: Color {
        switch order.status {
            case .cancelled:
                return .red
            case .accepted:
                return .blue
            case .outForDelivery:
                return .yellow
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
