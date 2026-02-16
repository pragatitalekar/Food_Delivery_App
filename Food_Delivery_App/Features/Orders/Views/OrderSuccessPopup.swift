//
//  OrderSuccessPopup.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/15/26.
//

import SwiftUI

struct OrderSuccessPopup: View {
    
    @Binding var show: Bool
    
    var body: some View {
        if show {
            ZStack {
                
                // Background Dim
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                    .onTapGesture {
                        show = false
                    }
                
                VStack {
                    Spacer()   // pushes popup to bottom
                    
                    VStack(spacing: 16) {
                        
                        Capsule()
                            .frame(width: 40, height: 5)
                            .foregroundColor(.gray.opacity(0.4))
                        
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 55, height: 55)
                            .foregroundColor(.green)
                        
                        Text("Order Placed Successfully 🎉")
                            .font(.headline)
                        
                        Text("Your food is being prepared")
                            .foregroundColor(.gray)
                        
                        Button("Track Order") {
                            show = false
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 12)
                    .padding()
                }
            }
            .transition(.move(edge: .bottom))
            .animation(.easeInOut, value: show)
        }
    }
}
