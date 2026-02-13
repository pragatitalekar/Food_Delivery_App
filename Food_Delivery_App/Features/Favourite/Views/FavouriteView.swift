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
                ForEach(favouriteItems, id: \.id) { item in
                    VStack(spacing: 8) {
                        NavigationLink {
                                  DetailView(item: item)
                              } label: {
                                  ItemCard(item: item)
                              }
                              .buttonStyle(.plain)

                        Button("Remove") {
                            cart.removeFavourite(item)
                        }
                        .foregroundColor(.red)
                    }
                }
            }
            .padding()

        }
        .navigationTitle("Favourites")
    }

   
    var favouriteItems: [FoodItems] {
        allItems.filter { cart.isFavourite($0) }
    }
}


