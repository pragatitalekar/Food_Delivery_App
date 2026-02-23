import SwiftUI

struct OrdersView: View {
    
    @EnvironmentObject var orders: OrderManager
    @Binding var selectedTab: TabType
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    @State private var animate = false
    @State private var showLoginAlert = false
    @State private var showAuth = false
    
    var body: some View {
        
        ZStack {
            
            // ⭐ NOT LOGGED IN STATE (same behaviour as favourites)
            if !isLoggedIn {
                
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    Image(systemName: "lock.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.orange)
                    
                    Text("Login Required")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Please login to view your orders")
                        .foregroundColor(.gray)
                    
                    Button {
                        showAuth = true
                    } label: {
                        Text("Login / Sign-up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(AppColors.primary)
                            .cornerRadius(30)
                            .padding(.horizontal, 30)
                    }
                    
                    Spacer()
                }
            }
            
            // ⭐ LOGGED IN STATE (your existing UI)
            else {
                
                VStack {
                    
                    if orders.activeOrders.isEmpty {
                        
                        Spacer()
                        
                        Image(systemName: "cart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.orange)
                            .scaleEffect(animate ? 1.1 : 0.9)
                            .animation(
                                Animation.easeInOut(duration: 1)
                                    .repeatForever(autoreverses: true),
                                value: animate
                            )
                            .onAppear { animate = true }
                        
                        Text("No orders yet")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                        
                        Text("Hit the orange button down\nbelow to Create an order")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                        
                        Spacer()
                        
                        Button {
                            selectedTab = .home
                        } label: {
                            Text("Start ordering")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .background(AppColors.primary)
                                .cornerRadius(30)
                                .padding(.horizontal, 30)
                        }
                        .padding(.bottom, 72)
                        
                    } else {
                        
                        List {
                            ForEach(orders.activeOrders) { order in
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    HStack {
                                        Text("Order #\(order.id.prefix(5))")
                                            .font(.headline)
                                        
                                        Spacer()
                                        
                                        Text("₹\(order.total, specifier: "%.0f")")
                                            .foregroundColor(.orange)
                                            .bold()
                                    }
                                    
                                    Text("Preparing...")
                                        .foregroundColor(.blue)
                                    
                                    Button("Cancel Order") {
                                        orders.cancelOrder(order)
                                    }
                                    .padding(.vertical, 8)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.red.opacity(0.1))
                                    .foregroundColor(.red)
                                    .cornerRadius(10)
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(15)
                                .shadow(color: AppColors.shadow, radius: 8, x: 0, y: 4)
                                .padding(.vertical, 6)
                            }
                        }
                    }
                }
            }
            
            // ⭐ LOGIN POPUP (same pattern as DetailView)
            if showLoginAlert {
                Color.black.opacity(0.35).ignoresSafeArea()
                
                VStack(spacing: 18) {
                    
                    Text("Login Required")
                        .font(.headline)
                    
                    Text("Please login to continue")
                        .foregroundColor(.gray)
                    
                    Button {
                        showLoginAlert = false
                        showAuth = true
                    } label: {
                        Text("Login / Sign-up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppColors.primary)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                    }
                    
                    Button("Cancel") {
                        showLoginAlert = false
                    }
                    .foregroundColor(.gray)
                }
                .padding(24)
                .background(Color(.systemBackground))
                .cornerRadius(20)
                .padding(40)
            }
        }
        .navigationTitle("Orders")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGray6))
        
        // ⭐ AUTH SHEET
        .sheet(isPresented: $showAuth) {
            AuthView {
                showAuth = false
                isLoggedIn = true
            }
        }
    }
}

