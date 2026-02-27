//
//  CategoryListView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/8/26.
//
import SwiftUI

struct CategoryListView: View {
    
    let items: [FoodItems]
    
    var body: some View {
        
        let leftColumnItems = items.enumerated()
            .filter { $0.offset % 2 == 0 }
            .map { $0.element }
        
        let rightColumnItems = items.enumerated()
            .filter { $0.offset % 2 != 0 }
            .map { $0.element }
        
        ScrollView {
            HStack(alignment: .top, spacing: 20) {
                
                // LEFT COLUMN
                LazyVStack(spacing: 40) {
                    ForEach(leftColumnItems) { item in
                        NavigationLink {
                            DetailView(item: item)
                        } label: {
                            ItemCard(item: item)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .frame(maxWidth: .infinity)
                
                // RIGHT COLUMN
                LazyVStack(spacing: 40) {
                    ForEach(rightColumnItems) { item in
                        NavigationLink {
                            DetailView(item: item)
                        } label: {
                            ItemCard(item: item)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .frame(maxWidth: .infinity)
                .offset(y: 60)
            }
            .padding(.horizontal, 20)
            .padding(.top, 40)
            .padding(.bottom, 120)
        }.navigationTitle(Text("Categories"))
        .background(Color(.systemGray6))
        .navigationBarTitleDisplayMode(.inline)
    }
}
