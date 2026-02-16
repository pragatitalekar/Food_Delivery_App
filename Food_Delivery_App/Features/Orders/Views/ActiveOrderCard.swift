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
                
                Spacer()
                
                Text("₹\(order.total, specifier: "%.0f")")
                    .foregroundColor(.orange)
                    .bold()
            }
            
            Text(statusText)
                .font(.subheadline)
                .foregroundColor(.blue)
            
            ProgressView(value: progress)
                .tint(.green) // GREEN PROGRESS
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 6)
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
        if progress < 0.3 { return "Restaurant accepted 🍽️" }
        if progress < 0.7 { return "Preparing your food 👨‍🍳" }
        if progress < 1.0 { return "Out for delivery 🚚" }
        return "Delivered 🎉"
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            updateProgress()
        }
    }
    
    func updateProgress() {
        let totalTime: Double = 1800
        let elapsed = Date().timeIntervalSince(order.createdAt)
        progress = min(elapsed / totalTime, 1.0)
    }
}
