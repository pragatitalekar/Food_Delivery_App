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
            
           
            VStack(spacing: 20) {
                
                Spacer().frame(height: 70)
                
                Text(item.name)
                    .font(.title2)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(maxWidth: 130)
                    .foregroundStyle(.black)
                
                Text("₹\(item.price, specifier: "%.0f")")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
            }
            .padding()
            .frame(width: 190, height: 230)
            .background(Color.white).opacity(0.85)
            .cornerRadius(30)
            .shadow(color: Color.gray.opacity(0.20), radius: 8, x: 0, y: 6)
            
            
          
            AsyncImage(url: URL(string: item.image)) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            .offset(y: -35)
        }
        .padding(.top, 40)
    }
}
