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
           
           HStack(spacing: 16) {
               
               AsyncImage(url: URL(string: item.image)) { img in
                   img.resizable().scaledToFill()
               } placeholder: {
                   ProgressView()
               }
               .frame(width: 80, height: 80)
               .cornerRadius(16)
               
               VStack(alignment: .leading, spacing: 6) {
                   Text(item.name)
                       .foregroundStyle(.black)
                       .font(.headline)
                   
                   Text("₹\(item.price, specifier: "%.0f")")
                       .foregroundColor(.orange)
                       .fontWeight(.bold)
               }
               
               Spacer()
               
               VStack(spacing: 12) {
                   
                   // Favourite Button
                   Button {
                       cart.toggleFavourite(item)
                   } label: {
                       Image(systemName: cart.isFavourite(item) ? "heart.fill" : "heart")
                           .foregroundColor(.red)
                           .font(.title3)
                   }
                   
                   // Remove Button
                   Button {
                       cart.remove(item)
                   } label: {
                       Image(systemName: "trash")
                           .foregroundColor(.gray)
                   }
               }
           }
           .padding()
           .background(Color.white)
           .cornerRadius(20)
           .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 3)
       }
}


