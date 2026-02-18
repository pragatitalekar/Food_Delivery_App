//
//  FavouriteView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/8/26.
//
import SwiftUI

struct FavouriteView: View {
  
    @EnvironmentObject var cart: CartManager
    let allItems: [FoodItems]

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 40),
                    GridItem(.flexible(), spacing: 40)
                ],
                spacing: 40
            ) {
                ForEach(favouriteItems) { item in
                    VStack(spacing: 8) {

                        NavigationLink {
                            DetailView(item: item)
                        } label: {
                            ItemCard(item: item)
                                .frame(width: 165, height: 250)
                        }
                        .buttonStyle(.plain)

                        Button {
                            cart.removeFavourite(item)
                        } label: {
                            Text("Remove")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Favourites")
        .background(Color(.systemGray6))
    }

    var favouriteItems: [FoodItems] {
        allItems.filter { cart.isFavourite($0) }
    }
}
