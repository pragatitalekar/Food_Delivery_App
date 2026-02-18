import SwiftUI

struct DetailView: View {

    let item: FoodItems
    @EnvironmentObject var cart: CartManager

    @State private var selectedIndex = 0
    @State private var showCartPopup = false
    @State private var goToCart = false

    var images: [String] {
        [item.image, item.image, item.image]
    }

    var body: some View {
        ZStack {

            VStack {

                ScrollView {
                    VStack(spacing: 0) {

                        // IMAGE CAROUSEL
                        TabView(selection: $selectedIndex) {
                            ForEach(images.indices, id: \.self) { index in
                                AsyncImage(url: URL(string: images[index])) { img in
                                    img.resizable().scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 220, height: 220)
                                .clipShape(Circle())
                                .tag(index)
                                .shadow(radius: 6)
                            }
                        }
                        .frame(height: 260)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .padding(.top, 20)

                        // DOT INDICATOR
                        HStack(spacing: 6) {
                            ForEach(images.indices, id: \.self) { index in
                                Circle()
                                    .fill(index == selectedIndex ? .orange : .gray.opacity(0.3))
                                    .frame(width: 6, height: 6)
                            }
                        }
                        .padding(.top, 8)

                        // NAME & PRICE
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

                        // INFO
                        VStack(alignment: .leading, spacing: 20) {

                            VStack(alignment: .leading, spacing: 6) {
                                Text("Delivery info")
                                    .font(.headline)

                                Text("Delivered within 30–45 mins at your location.")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            VStack(alignment: .leading, spacing: 6) {
                                Text("About food")
                                    .font(.headline)

                                Text("Fresh and tasty food prepared with quality ingredients. Perfect for lunch and dinner cravings.")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 30)

                        Spacer(minLength: 120)
                    }
                }

                // ADD TO CART BUTTON
                Button {
                    cart.increment(item)   // ✅ FIXED
                    showPopup()
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

            // FLOATING CART POPUP
            if showCartPopup {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()

                        Button {
                            goToCart = true
                        } label: {
                            Image(systemName: "cart.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(14)
                                .background(Color.orange)
                                .clipShape(Circle())
                                .shadow(radius: 6)
                        }
                        .padding(.trailing, 25)
                        .padding(.bottom, 90)
                    }
                }
                .transition(.scale.combined(with: .opacity))
                .animation(.easeInOut, value: showCartPopup)
            }

            // NAVIGATION LINK
            NavigationLink(destination: CartView(), isActive: $goToCart) {
                EmptyView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    cart.toggleFavourite(item)
                } label: {
                    Image(systemName: cart.isFavourite(item) ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
            }
        }
    }

    // POPUP ANIMATION
    func showPopup() {
        withAnimation { showCartPopup = true }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation { showCartPopup = false }
        }
    }
}
