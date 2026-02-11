//
//  CartView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/8/26.
//
import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var cart: CartManager

    var body: some View {
        VStack {
            
            List {
                
                ForEach(uniqueItems, id: \.id) { item in
                    
                    HStack(spacing: 12) {
                        
                       
                        AsyncImage(url: URL(string: item.image)) { img in
                            img.resizable().scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                        
                       
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            
                            Text("₹\(item.price, specifier: "%.0f")")
                                .foregroundColor(.orange)
                        }
                        
                        Spacer()
                        
                       
                        HStack {
                            Button {
                                cart.decrement(item)
                            } label: {
                                Image(systemName: "minus.circle.fill")
                            }
                            
                            Text("\(cart.quantity(of: item))")
                                .frame(width: 24)
                            
                            Button {
                                cart.increment(item)
                            } label: {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                        .foregroundColor(.orange)
                    }
                    
                 
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
                    
                   
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            cart.remove(item)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }

         
            Text("Total ₹\(cart.total, specifier: "%.0f")")
                .font(.title2)
                .padding()

          
            Button("Checkout") { }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.orange)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
        }
        .navigationTitle("Cart")
    }
    
    var uniqueItems: [FoodItems] {
        Array(Dictionary(grouping: cart.items, by: { $0.id }).values.compactMap { $0.first })
    }
}



#Preview {
    CartView()
}




