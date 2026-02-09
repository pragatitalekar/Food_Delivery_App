//
//  ProductDetailedView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import SwiftUI

struct ProductDetailedView: View {

    // MARK: - State
    @State private var selectedImageIndex = 0

    // MARK: - Image Data (replace with real assets)
    let images = [
        "spaghetti",
        "spaghetti2",
        "spaghetti3"
    ]

    var body: some View {
        VStack {

            // Scrollable content
            ScrollView {
                VStack(spacing: 0) {

                    // MARK: - Swipeable Images
                    TabView(selection: $selectedImageIndex) {
                        ForEach(images.indices, id: \.self) { index in
                            Image(images[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 220, height: 220)
                                .clipShape(Circle())
                                .tag(index)
                        }
                    }
                    .frame(height: 260)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .padding(.top, 20)

                    // MARK: - Page Indicators
                    HStack(spacing: 6) {
                        ForEach(images.indices, id: \.self) { index in
                            Circle()
                                .fill(
                                    index == selectedImageIndex
                                    ? Color.orange
                                    : Color.gray.opacity(0.3)
                                )
                                .frame(width: 6, height: 6)
                        }
                    }
                    .padding(.top, 8)

                    // MARK: - Title & Price
                    VStack(spacing: 8) {
                        Text("Veggie tomato mix")
                            .font(.title2)
                            .fontWeight(.semibold)

                        Text("₦1,900")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    }
                    .padding(.top, 30)

                    // MARK: - Info Sections
                    VStack(alignment: .leading, spacing: 20) {

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Delivery info")
                                .font(.headline)

                            Text("Delivered between monday aug and thursday 20 from 8pm - 9:13 pm")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Return policy")
                                .font(.headline)

                            Text("All our foods are double checked before leaving our stores so by any case you found a broken food please contact our hotline immediately.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 30)

                    Spacer(minLength: 80)
                }
            }

            // MARK: - Sticky Add to Cart Button
            Button {
                print("Add to cart tapped")
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

#Preview {
    NavigationStack {
        ProductDetailedView()
    }
}
