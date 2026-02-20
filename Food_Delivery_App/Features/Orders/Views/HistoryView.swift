import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject var orders: OrderManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            if orders.historyOrders.isEmpty {
                
                VStack {
                    
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
                    
                    Text("Hit the orange button down\nbelow to create an order")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Start Ordering")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color.orange)
                            .cornerRadius(30)
                            .padding(.horizontal, 30)
                    }
                    .padding(.bottom, 30)
                }
                
            } else {
                
                ScrollView {
                    LazyVStack(spacing: 18) {
                        
                        // ✅ SORTED (Newest First)
                        ForEach(
                            orders.historyOrders
                                .sorted { $0.createdAt > $1.createdAt }
                        ) { order in
                            
                            HistoryCard(order: order)
                                .transition(.move(edge: .top).combined(with: .opacity))
                        }
                    }
                    .padding()
                }
                .animation(.easeInOut, value: orders.historyOrders)
            }
        }
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            orders.removeExpiredHistory()
        }
    }
}
