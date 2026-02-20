import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject var orders: OrderManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack {
            
            if orders.historyOrders.isEmpty {
                
                Spacer()
                
                Image(systemName: "calendar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 110)
                    .foregroundColor(.gray.opacity(0.4))
                
                Text("No history yet")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Text("Hit the orange button down\nbelow to Create an order")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.top, 8)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Text("Start ordering")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.orange)
                        .cornerRadius(30)
                        .padding(.horizontal, 30)
                }
                .padding(.bottom, 30)
                
            } else {
                
                List {
                    ForEach(orders.historyOrders) { order in
                        VStack(alignment: .leading, spacing: 8) {
                            
                            HStack {
                                Text("Order #\(order.id.prefix(5))")
                                    .font(.headline)
                                
                                Spacer()
                                
                                Text("₹\(order.total, specifier: "%.0f")")
                                    .foregroundColor(.green)
                                    .bold()
                            }
                            
                            Text("Items: \(order.items.count)")
                                .foregroundColor(.gray)
                            
                            Text(order.status.rawValue.capitalized)
                                .foregroundColor(
                                    order.status == .cancelled ? .red : .green
                                )
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                        .shadow(radius: 3)
                        .padding(.vertical, 6)
                    }
                }
            }
        }
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGray6))
        .onAppear {
            orders.removeExpiredHistory()
        }
    }
}
