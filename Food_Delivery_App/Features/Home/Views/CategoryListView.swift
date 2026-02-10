//
//  CategoryListView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/8/26.
//

import SwiftUI

struct CategoryListView: View {
    let items: [FoodItems]
    @EnvironmentObject var cart: CartManager

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(items) { item in
                    NavigationLink {
                        DetailView(item: item)
                    } label: {
                        ItemCard(item: item)
                    }
                }
            }
            .padding()
        }
    }
}

