//
//  ItemCard.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/8/26.
//

import SwiftUI

struct ItemCard: View {
    
    let item: FoodItems
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            VStack(spacing: 12) {
                
                Spacer().frame(height: 55)
                
                Text(item.name)
                    .font(.title3)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(maxWidth: 130)
                    .foregroundStyle(.black)
                
                Text("₹\(item.price, specifier: "%.0f")")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 18)
            .frame(width: 180, height: 210)
            .background(Color.white.opacity(0.9))
            .cornerRadius(28)
            .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 6)
            
            
            AsyncImage(url: URL(string: item.image)) { img in
                img
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 110, height: 110)
            .clipShape(Circle())
            .offset(y: -30)
            
        }
        
    }
}
