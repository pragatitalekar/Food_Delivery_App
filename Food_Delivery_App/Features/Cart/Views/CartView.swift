import SwiftUI

struct CartView: View {

    @EnvironmentObject var cart: CartManager
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    @State private var showAuth = false
    @State private var navigateToAddress = false

    var body: some View {

        Group {

            // ❌ NOT LOGGED IN
            if !isLoggedIn {

                VStack(spacing: 24) {

                    Spacer()

                    Image(systemName: "cart.badge.exclam")
                        .font(.system(size: 70))
                        .foregroundColor(.gray.opacity(0.6))

                    Text("You are not logged in")
                        .font(.title3)
                        .fontWeight(.semibold)

                    Text("Login to view and manage your cart")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Button {
                        showAuth = true
                    } label: {
                        Text("Login / Sign-up")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppColors.primary)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                    }
                    .padding(.horizontal, 30)

                    Spacer()
                }
                .sheet(isPresented: $showAuth) {
                    AuthView {
                        showAuth = false
                        isLoggedIn = true
                    }
                }
            }

            // ✅ LOGGED IN → CART UI
            else {

                VStack(spacing: 12) {

                    Text("swipe on an item to delete")
                        .font(.caption)
                        .foregroundColor(.gray)

                    List {
                        ForEach(cartItems) { item in

                            NavigationLink {
                                DetailView(item: item)
                            } label: {

                                CartItemCard(
                                    item: item,
                                    quantity: cart.quantity(of: item),
                                    onIncrement: { cart.increment(item) },
                                    onDecrement: { cart.decrement(item) }
                                )
                            }
                            .buttonStyle(.plain)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)

                            // Favourite
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

                            // Delete
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    cart.remove(item)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(.plain)

                    // Total
                    HStack {
                        Text("Total")
                            .font(.headline)

                        Spacer()

                        Text("₹\(cart.total, specifier: "%.0f")")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    }
                    .padding(.horizontal)

                    Button {
                        navigateToAddress = true
                    } label: {
                        Text("Complete Order")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                    }
                    .padding(.horizontal)

                    NavigationLink("", destination: AddressView(), isActive: $navigateToAddress)
                }
            }
        }
        .navigationTitle("Cart")
        .background(Color(.systemGray6))
        .onAppear {
            cart.loadCart()
        }
    }

    // Stable ordering
    var cartItems: [FoodItems] {
        cart.items.values
            .sorted { $0.item.name < $1.item.name }
            .map { $0.item }
    }
}
