//
//  OrdersView.swift
//

import SwiftUI

struct OrdersView: View {
    
    @EnvironmentObject var orders: OrderManager
    @Binding var selectedTab: TabType
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    @State private var showAuth = false
    @State private var animate = false
    
    var body: some View {
        
        ZStack {
            
            Color(.systemGray6)
                .ignoresSafeArea()
            
            Group {
                
                // MARK: - NOT LOGGED IN
                
                if !isLoggedIn {
                    
                    VStack(spacing: 24) {
                        
                        Spacer()
                        
                        Image(systemName: "cart.badge.questionmark")
                            .font(.system(size: 70))
                            .foregroundColor(.gray.opacity(0.6))
                        
                        Text("No orders yet")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("Login to view your orders")
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
                            orders.listenToOrders()
                        }
                    }
                }
                
                // MARK: - NO ACTIVE ORDERS
                
                else if orders.activeOrders.isEmpty {
                    
                    VStack(spacing: 20) {
                        
                        Spacer()
                        
                        Image(systemName: "cart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.orange)
                            .scaleEffect(animate ? 1.15 : 0.9)
                            .animation(
                                .easeInOut(duration: 1)
                                .repeatForever(autoreverses: true),
                                value: animate
                            )
                            .onAppear {
                                animate = true
                            }
                        
                        Text("No orders yet")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Text("Hit the orange button below\nto create an order")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                        
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
                        .padding(.bottom, 120)
                    }
                }
                
                // MARK: - ORDERS LIST
                
                else {
                    ordersList
                }
            }
        }
        .navigationTitle("Orders")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if isLoggedIn {
                orders.listenToOrders()
            }
        }
    }
}

// MARK: - Orders List

private extension OrdersView {
    
    var ordersList: some View {
        
        List {
            ForEach(orders.activeOrders) { order in
                
                NavigationLink {
                    OrderTrackingView(order: order)
                } label: {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        HStack {
                            Text("Order #\(order.id.prefix(5))")
                                .font(.headline)
                            
                            Spacer()
                            
                            Text("₹\(order.total, specifier: "%.0f")")
                                .foregroundColor(.orange)
                                .bold()
                        }
                        
                        Text("Tap to track delivery")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .background(AppColors.background)
                    .cornerRadius(16)
                    .shadow(radius: 5)
                }
                .buttonStyle(.plain)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .padding(.vertical, 60)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}
