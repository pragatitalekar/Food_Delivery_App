//
//  OrderTrackingView.swift
//

import SwiftUI

struct OrderTrackingView: View {
    
    var order: Order
    private let deliveryDuration: TimeInterval = 600
    
    @EnvironmentObject var cart: CartManager
    @EnvironmentObject var orders: OrderManager
    @Environment(\.dismiss) private var dismiss
    
    @State private var progress: Double = 0
    @State private var remainingTime: TimeInterval = 0
    @State private var timer: Timer?
    
    @State private var showCancelAlert = false
    @State private var showRefundAlert = false
    
    @StateObject private var foodVM = SimilarFoodViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color(.systemGray6)
                .ignoresSafeArea()
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 25) {
                    
                   
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Order Summary")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Text("\(order.items.count) Item(s)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        ForEach(order.items, id: \.id) { item in
                            
                            HStack {
                                Text(item.name)
                                Spacer()
                                Text("₹\(item.price, specifier: "%.0f")")
                            }
                            
                            Divider()
                        }
                        
                        HStack {
                            Text("Total")
                                .fontWeight(.semibold)
                            Spacer()
                            Text("₹\(order.total, specifier: "%.0f")")
                                .fontWeight(.bold)
                        }
                    }
                    .padding()
                    .background(AppColors.background)
                    .cornerRadius(16)
                    
                    
                    
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Order #\(order.id.prefix(5))")
                            .font(.headline)
                        
                        Text(currentStatus)
                            .font(.title3)
                            .bold()
                            .foregroundColor(.green)
                        
                        ProgressView(value: progress)
                            .tint(.green)
                        
                        HStack {
                            Image(systemName: "clock.fill")
                                .foregroundColor(.orange)
                            
                            Text(timeString)
                                .font(.title3)
                                .bold()
                                .foregroundColor(.orange)
                        }
                    }
                    .padding()
                    .background(AppColors.background)
                    .cornerRadius(16)
                    
                    
                  
                    
                    if order.status == .preparing {
                        
                        Button {
                            showCancelAlert = true
                        } label: {
                            Text(progress > 0.6 ? "Cannot Cancel (Out for Delivery)" : "Cancel Order")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(progress > 0.6 ? Color.gray : AppColors.primary)
                                .foregroundColor(.white)
                                .cornerRadius(14)
                        }
                        .disabled(progress > 0.6)
                        .opacity(progress > 0.6 ? 0.5 : 1)
                        .animation(.easeInOut(duration: 0.3), value: progress)
                    }
                    
                 
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        TrackingRow(
                            title: "Order Confirmed",
                            subtitle: "Your order has been placed",
                            isCompleted: progress > 0.1
                        )
                        
                        TrackingRow(
                            title: "Preparing",
                            subtitle: "Restaurant is preparing food",
                            isCompleted: progress > 0.2
                        )
                        
                        TrackingRow(
                            title: "Out for Delivery",
                            subtitle: "Delivery partner picked up",
                            isCompleted: progress > 0.6
                        )
                        
                        TrackingRow(
                            title: "Delivered",
                            subtitle: "Order delivered successfully",
                            isCompleted: progress >= 1.0
                        )
                    }
                    .padding()
                    .background(AppColors.background)
                    .cornerRadius(16)
                    
                    
                    
                    Text("You may also like")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    if foodVM.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(foodVM.foods) { food in
                                SimilarFoodCard(food: food)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Track Order")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            startTimer()
            foodVM.fetchSimilarFoods(for: order)
        }
        .onDisappear {
            timer?.invalidate()
        }
        .alert("Cancel Order?", isPresented: $showCancelAlert) {
            
            Button("Yes, Cancel", role: .destructive) {
                orders.cancelOrder(order)
                showRefundAlert = true
            }
            
            Button("No", role: .cancel) { }
            
        } message: {
            Text("If cancelled now, your payment will be refunded instantly.")
        }
        .alert("Refund Processed 💸", isPresented: $showRefundAlert) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("₹\(order.total, specifier: "%.0f") has been refunded successfully.")
        }
    }
    
    
   
    
    var currentStatus: String {
        if progress < 0.3 { return "Restaurant accepted 🍽️" }
        if progress < 0.6 { return "Food is being prepared 👨‍🍳" }
        if progress < 0.9 { return "Out for delivery 🚚" }
        return "Delivered 🎉"
    }
    

    
    func startTimer() {
        updateValues()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            updateValues()
        }
    }
    
    func updateValues() {
        let elapsed = Date().timeIntervalSince(order.createdAt)
        remainingTime = max(deliveryDuration - elapsed, 0)
        progress = min(elapsed / deliveryDuration, 1.0)
        
        if remainingTime <= 0 {
            timer?.invalidate()
        }
    }
    
    var timeString: String {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        return String(format: "Arriving in %02d:%02d", minutes, seconds)
    }
}




struct TrackingRow: View {
    
    var title: String
    var subtitle: String
    var isCompleted: Bool
    
    var body: some View {
        
        HStack(alignment: .top) {
            
            VStack {
                Circle()
                    .fill(isCompleted ? Color.green : Color.gray.opacity(0.4))
                    .frame(width: 18, height: 18)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 2)
                    .frame(maxHeight: .infinity)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .fontWeight(.semibold)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
    }
}




struct SimilarFoodCard: View {
    
    let food: FoodItems
    @EnvironmentObject var cart: CartManager
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 10) {
                
                Spacer().frame(height: 70)
                
                Text(food.name)
                    .font(.headline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(maxWidth: 130)
                    .foregroundColor(AppColors.textPrimary)
                
                Text("₹\(food.price, specifier: "%.0f")")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.primary)
                
                Button {
                    cart.add(food)
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "plus")
                        Text("Add")
                            .fontWeight(.semibold)
                    }
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(AppColors.primary)
                    .cornerRadius(20)
                }
                .padding(.top, 5)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 6)
            .frame(width: 165, height: 210)
            .background(AppColors.background)
            .cornerRadius(24)
            .shadow(color: AppColors.shadow, radius: 8, x: 0, y: 4)
            
            AsyncImage(url: URL(string: food.image)) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            .background(Circle().fill(Color.white))
            .offset(y: -75)
        }
        .frame(width: 165, height: 280)
    }
}
