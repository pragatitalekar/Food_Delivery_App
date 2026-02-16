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
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )

                // 🔥 QUANTITY BADGE
                if cart.quantity(of: item) > 0 {
                    Text("\(cart.quantity(of: item))")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color.orange)
                        .clipShape(Circle())
                        .offset(x: -6, y: 6)
                }

                // FAV BUTTON
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
        .background(Color(.systemGray6))
    }
}
