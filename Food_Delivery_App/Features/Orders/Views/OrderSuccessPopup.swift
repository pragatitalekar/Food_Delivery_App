//
//  OrderSuccessPopup.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/15/26.
//

import SwiftUI

struct OrderSuccessPopup: View {
    
    @Binding var show: Bool
    var onOpenOrder: () -> Void
    
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
                    
                    Button {
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
                .shadow(color: AppColors.shadow, radius: 8, x: 0, y: 4)
                .padding(.horizontal)
                .padding(.bottom, 90)   
            }
            .transition(.move(edge: .bottom))
            .animation(.easeInOut, value: show)
        }
    }
}
