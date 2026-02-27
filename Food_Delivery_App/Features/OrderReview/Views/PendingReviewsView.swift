//
//  PendingReviewsView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/26/26.
//

import SwiftUI

struct PendingReviewsView: View {
    
    @EnvironmentObject var orders: OrderManager
    
    var pendingOrders: [Order] {
        orders.historyOrders.filter {
            $0.status == .delivered && $0.review == nil
        }
    }
    
    var body: some View {
        
        ZStack {
            
            Color(.systemGray6)
                .ignoresSafeArea()
            
            if pendingOrders.isEmpty {
                
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    Image(systemName: "star.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray.opacity(0.4))
                    
                    Text("No Pending Reviews")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("All your delivered orders are reviewed 🎉")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Spacer()
                }
                
            } else {
                
                ScrollView {
                    LazyVStack(spacing: 18) {
                        
                        ForEach(pendingOrders) { order in
                            HistoryCard(order: order)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Pending Reviews")
        .navigationBarTitleDisplayMode(.inline)
    }
}
