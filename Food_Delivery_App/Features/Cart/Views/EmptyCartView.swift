//
//  EmptyCartView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/19/26.
//

import SwiftUI

struct EmptyCartView: View {
    
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()
            
            Image(systemName: "cart")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundColor(.orange)
                .scaleEffect(animate ? 1.1 : 0.9)
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true),
                    value: animate
                )
            
            Text("Your Cart is Empty")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Looks like you haven't added anything yet.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
        .onAppear {
            animate = true
        }
    }
}
#Preview {
    EmptyCartView()
}
