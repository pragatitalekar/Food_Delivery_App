import SwiftUI

struct OrdersView: View {
    
    @EnvironmentObject var orders: OrderManager
    @Binding var selectedTab: TabType
    @State private var animate = false
    
    var body: some View {
        
        VStack {
            
            if orders.activeOrders.isEmpty {
                
                Spacer()
                
                // CART ICON
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
                
                    .onAppear {
                        animate = true
                    }
                // TITLE
                Text("No orders yet")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                // SUBTITLE
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
        .navigationTitle("Orders")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGray6))
    }
}
