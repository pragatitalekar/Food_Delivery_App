import SwiftUI

struct CartView: View {

    @EnvironmentObject var cart: CartManager
    
    @State private var navigateToAddress = false
    @State private var showEmptyAlert = false

    var body: some View {
        
        VStack(spacing: 12) {
            
            Text("Swipe on an item to delete")
                .font(.caption)
                .foregroundColor(.gray)
            
            // MARK: - EMPTY STATE
            if cart.items.isEmpty {
                
                EmptyCartView()
                
            } else {
                
                // MARK: - CART LIST
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
                        .buttonStyle(.plain)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        
                        // ❤️ Favourite (Right Swipe)
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
                        
                        // 🗑 Delete (Left Swipe)
                        .swipeActions(edge: .trailing, allowsFullSwipe:false) {
                            Button(role: .destructive) {
                                cart.remove(item)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            
            // MARK: - TOTAL SECTION
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
            
            // MARK: - COMPLETE ORDER BUTTON
            Button {
                if cart.items.isEmpty {
                    showEmptyAlert = true
                } else {
                    navigateToAddress = true
                }
            } label: {
                Text("Complete Order")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(cart.items.isEmpty ? Color.gray : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(14)
            }
            .padding(.horizontal)
            
            // Hidden NavigationLink
            NavigationLink(
                destination: AddressView(),
                isActive: $navigateToAddress
            ) {
                EmptyView()
            }
            .hidden()
        }
        .navigationTitle("Cart")
        .onAppear {
            cart.loadCart()
        }
        .alert("Cart is Empty", isPresented: $showEmptyAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please add items to your cart before completing the order.")
        }
    }
    
    // MARK: - Stable Ordering
    var cartItems: [FoodItems] {
        cart.items.values
            .sorted { $0.item.name < $1.item.name }
            .map { $0.item }
    }
}
