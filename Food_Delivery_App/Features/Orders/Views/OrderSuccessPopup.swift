//
//  OrderSuccessPopup.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/15/26.
//
//
//  OrderSuccessPopup.swift
//

import SwiftUI

struct OrderSuccessPopup: View {
    
    @Binding var show: Bool
    var onOpenOrder: () -> Void
    
   
    private let deliveryDuration: TimeInterval = 600
    
    @State private var remainingTime: TimeInterval = 600
    @State private var timer: Timer?
    
    var body: some View {
        
        if show {
            VStack {
                Spacer()
                
                VStack(spacing: 16) {
                    
                    Capsule()
                        .frame(width: 40, height: 5)
                        .foregroundColor(.gray.opacity(0.4))
                    
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.green)
                    
                    Text("Order Placed Successfully 🎉")
                        .font(.headline)
                    
                    Text("Your food is being prepared")
                        .foregroundColor(.gray)
                    
                    // 🔥 Countdown Section
                    
                    HStack(spacing: 6) {
                        Image(systemName: "clock.fill")
                            .foregroundColor(.orange)
                        
                        Text(timeString)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    }
                    
                    Button {
                        timer?.invalidate()
                        show = false
                        onOpenOrder()
                    } label: {
                        Text("View Order Details")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(25)
                .shadow(color: AppColors.shadow,
                        radius: 8, x: 0, y: 4)
                .padding(.horizontal)
                .padding(.bottom, 90)
            }
            .transition(.move(edge: .bottom))
            .animation(.easeInOut, value: show)
            .onAppear {
                startTimer()
            }
            .onDisappear {
                timer?.invalidate()
            }
        }
    }
    
    
    // MARK: - Timer Logic
    
    private func startTimer() {
        
        remainingTime = deliveryDuration
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                timer?.invalidate()
            }
        }
    }
    
    
    private var timeString: String {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        return String(format: "Arriving in %02d:%02d", minutes, seconds)
    }
}
