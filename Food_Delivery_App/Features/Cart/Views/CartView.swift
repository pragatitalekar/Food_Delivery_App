//
//  CartView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/8/26.
//
//
import SwiftUI

struct CartView: View {

    @EnvironmentObject var cart: CartManager

    var body: some View {
        VStack {

            List {
                ForEach(cart.items) { cartItem in
                    let item = cartItem.item

                    HStack(spacing: 12) {

                        AsyncImage(url: URL(string: item.image)) { img in
                            img.resizable().scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )

                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)

                            Text("₹\(item.price, specifier: "%.0f")")
                                .foregroundColor(.orange)
                        }

                        Spacer()

                        HStack(spacing: 14) {

                            Button {
                                cart.decrement(item)
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .font(.title2)
                            }

                            Text("\(cartItem.qty)")
                                .frame(width: 30)

                            Button {
                                cart.increment(item)
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                            }
                        }
                        .foregroundColor(.orange)
                    }

                    // FAV
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button {
                            cart.toggleFavourite(item)
                        } label: {
                            Label(
                                cart.isFavourite(item) ? "Unfavourite" : "Favourite",
                                systemImage: cart.isFavourite(item) ? "heart.slash" : "heart"
                            )
                        }
                        .tint(.pink)
                    }

                    // DELETE
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            cart.remove(item)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }

            // TOTAL
            HStack {
                Text("Total")
                Spacer()
                Text("₹\(cart.total, specifier: "%.0f")")
            }
            .font(.title2)
            .padding()

            NavigationLink {
                AddressView()
            } label: {
                Text("Complete Order")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.orange)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
            }
        }
        .navigationTitle("Cart")
        .background(Color(.systemGray6))
    }
}

#Preview {
    CartView()
        .environmentObject(CartManager())
}





