//
//  ActiveOrderCard.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/15/26.
//
import SwiftUI

struct ActiveOrderCard: View {
    
    var order: Order
    
    @State private var progress: Double = 0
    @State private var timer: Timer?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Text("Order #\(order.id.prefix(5))")
                    .font(.headline)
                    .foregroundStyle(AppColors.textPrimary)
                
                Spacer()
                
                Text("₹\(order.total, specifier: "%.0f")")
                    .foregroundColor(AppColors.primary)
                    .bold()
            }
            
            Text(statusText)
                .font(.subheadline)
                .foregroundColor(.blue)
            
            ProgressView(value: progress)
                .tint(.green) 
        }
        .padding()
        .background(AppColors.background)
        .cornerRadius(16)
        .shadow(color: AppColors.shadow, radius: 8, x: 0, y: 4)
        .padding(.horizontal)
        .onAppear {
            updateProgress()
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    var statusText: String {
        if progress < 0.1 { return "Restaurant accepted 🍽️" }
        if progress < 0.6 { return "Preparing your food 👨‍🍳" }
        if progress < 1.0 { return "Out for delivery 🚚" }
        return "Delivered 🎉"
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            updateProgress()
        }
    }
    
    func updateProgress() {
        let totalTime: Double = 600    // 30mins
        let elapsed = Date().timeIntervalSince(order.createdAt)
        progress = min(elapsed / totalTime, 1.0)
    }
}
