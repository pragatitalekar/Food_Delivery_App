//
//  SearchView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/5/26.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText = ""
    
    let foods = ["Pizza", "Burger", "Pasta", "Sandwich", "Biryani"]
    
    var filteredFoods: [String] {
        if searchText.isEmpty {
            return foods
        } else {
            return foods.filter {
                $0.lowercased().contains(searchText.lowercased())
            }
        }
    }
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search", text: $searchText)
                .autocorrectionDisabled()
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                
            }
        }.padding()
            .background(Color(.systemGray6))
            .cornerRadius(30)
            .offset(x: 6, y: -280)
        if !searchText.isEmpty {
            ForEach(filteredFoods,id: \.self){food in
                Text(food)
                    .padding(.vertical)
                    .offset(x: -120,y:-200)
                
            }
            
            
        }
    }
}

#Preview {
    SearchView()
}
