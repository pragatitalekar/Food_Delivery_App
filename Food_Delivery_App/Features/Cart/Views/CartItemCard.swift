//
//  CartItemCard.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/9/26.
//

import SwiftUI
import Combine

struct CartItemCard: View {
    let item: FoodItems
    @EnvironmentObject var cart: CartManager
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ZStack(alignment: .topTrailing) {
                
                AsyncImage(url: URL(string: item.image)) { img in
                    img.resizable().scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 120)
                .cornerRadius(12)
                
                Button {
                    cart.toggleFavourite(item)
                } label: {
                    Image(systemName: cart.isFavourite(item) ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                        .padding(6)
                        .background(.white)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
                .padding(6)
            }
            
            Text(item.name)
                .bold()
                .lineLimit(1)
            
            Text("₹\(item.price, specifier: "%.0f")")
                .foregroundColor(.orange)
        }
        .frame(width: 150)
        .background(.white)
        .cornerRadius(15)
        .shadow(radius: 3)
    }
    
}

