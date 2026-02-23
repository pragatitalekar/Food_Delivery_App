//
//  OrderSuccessView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/19/26.
//

import SwiftUI

struct OrderSuccessView: View {
    
    @State private var animate = false
    
    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                ZStack {
                    Circle()
                        .fill(Color.green.opacity(0.2))
                        .frame(width: 140, height: 140)
                        .scaleEffect(animate ? 1 : 0.5)
                        .animation(.easeOut(duration: 0.5), value: animate)
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.green)
                }
                
                Text("Order Placed Successfully!")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Your delicious food is being prepared 🍔")
                    .font(.subheadline)
                    .foregroundColor(AppColors.textPrimary)
            }
        }
        .onAppear {
            animate = true
        }
    }
}

