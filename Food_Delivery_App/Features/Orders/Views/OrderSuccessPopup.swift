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
                Color.black.opacity(0.4).ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.green)
                    
                    Text("Order Placed Successfully 🎉")
                        .font(.title3)
                        .bold()
                    
                    Text("Your food is being prepared")
                        .foregroundColor(.gray)
                    
                    Button("OK") {
                        show = false
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(30)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal, 30)
            }
        }
    }
}

