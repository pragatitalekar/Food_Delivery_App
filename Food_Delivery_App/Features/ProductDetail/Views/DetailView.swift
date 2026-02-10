//
//  DetailView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/8/26.
//
import SwiftUI

struct DetailView: View {

    let item: FoodItems
    @EnvironmentObject var cart: CartManager
    
    @State private var selectedIndex = 0

  
    var images: [String] {
        [item.image, item.image, item.image]
    }

    var body: some View {
        VStack {

            ScrollView {
                VStack(spacing: 0) {

                  
                    TabView(selection: $selectedIndex) {
                        ForEach(images.indices, id: \.self) { index in
                            AsyncImage(url: URL(string: images[index])) { img in
                                img.resizable()
                                   .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 220, height: 220)
                            .clipShape(Circle())
                            .tag(index)
                            .shadow(color: Color.gray.opacity(0.8), radius: 6, x: 0, y: 4)
                        }
                    }
                    .frame(height: 260)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .padding(.top, 20)

                  
                    HStack(spacing: 6) {
                        ForEach(images.indices, id: \.self) { index in
                            Circle()
                                .fill(index == selectedIndex ? .orange : .gray.opacity(0.3))
                                .frame(width: 6, height: 6)
                        }
                    }
                    .padding(.top, 8)

                 
                    VStack(spacing: 8) {
                        Text(item.name)
                            .font(.title2)
                            .fontWeight(.semibold)

                        Text("₹\(item.price, specifier: "%.0f")")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    }
                    .padding(.top, 30)

                   
                    VStack(alignment: .leading, spacing: 20) {

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Delivery info")
                                .font(.headline)

                            Text("Delivered within 30-45 mins at your location.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("About food")
                                .font(.headline)

                            Text("Fresh and tasty food prepared with quality ingredients.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 30)

                    Spacer(minLength: 90)
                }
            }

        
            Button {
                cart.add(item)
            } label: {
                Text("Add to cart")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(30)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    print("Favorite tapped")
                } label: {
                    Image(systemName: "heart")
                        .foregroundColor(.black)
                }
            }
        }
    }
}
