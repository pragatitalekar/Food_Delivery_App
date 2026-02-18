import SwiftUI

struct CartView: View {

    @EnvironmentObject var cart: CartManager

    var body: some View {
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
                            onIncrement: {
                                cart.increment(item)
                            },
                            onDecrement: {
                                cart.decrement(item)
                            }
                        )
                    }
                    .buttonStyle(.plain)                 // 🔑 critical
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)

                    // ❤️ Favourite (RIGHT swipe)
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

                    // 🗑 HARD DELETE (LEFT swipe)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            cart.remove(item)   // MUST be hard delete
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .id(cart.items.count)


         
            HStack {
                Text("Total")
                Spacer()
                Text("₹\(cart.total, specifier: "%.0f")")
            }
            .font(.title2)
            .padding()

            


            NavigationLink {
                AddressView()
            } label: {
                Text("Complete Order")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(20)

            }
            .padding(.horizontal)
        }
        .navigationTitle("Cart")
        .background(Color(.systemGray6))
        .onAppear {
            cart.loadCart()
        }
    }

    // ✅ Stable ordering (VERY important)
    var cartItems: [FoodItems] {
        cart.items.values
            .sorted { $0.item.name < $1.item.name }
            .map { $0.item }
    }
}

#Preview {
    CartView()
        .environmentObject(CartManager())
}



