//
//  AddressView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//



import SwiftUI

struct AddressView: View {
    
    @EnvironmentObject var cart: CartManager
    @EnvironmentObject var orders: OrderManager
    
    @StateObject private var viewModel = AddressViewModel()
    
    @State private var selectedDelivery: DeliveryType = .door
    
    enum DeliveryType: String {
        case door
        case pickup
    }
    
    
    private var defaultAddress: UserAddress? {
        viewModel.addresses.first(where: { $0.isDefault })
    }
    
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 32) {
                
                
                Text("Delivery")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    
                    HStack {
                        
                        Text("Address details")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        
                        NavigationLink {
                            AddressListView()
                                .onDisappear {
                                    viewModel.load()
                                }
                        } label: {

                            Text("Change")
                                .font(.footnote)
                                .foregroundColor(.orange)
                        }
                    }
                    
                    
                    CardView {
                        
                        if let address = defaultAddress {
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Text(address.name)
                                    .font(.headline)
                                
                                Text(address.fullName)
                                    .font(.footnote)
                                
                                Text(address.street)
                                    .font(.footnote)
                                
                                Text(address.phone)
                                    .font(.footnote)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                        } else {
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Text("No address selected")
                                    .font(.headline)
                                
                                Text("Tap change to add or select address")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("Delivery method")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    
                    CardView {
                        
                        VStack(spacing: 16) {
                            
                            deliveryRow(title: "Door delivery", type: .door)
                            
                            Divider()
                            
                            deliveryRow(title: "Pick up", type: .pickup)
                        }
                    }
                }
                
                
                Spacer()
                
                
                HStack {
                    
                    Text("Total")
<<<<<<< HEAD:Food_Delivery_App/Features/Checkout/Views/AddressView.swift
                    Spacer()
                    
                    Text("₹\(cart.total, specifier: "%.0f")")
                   
=======
                    
                    Spacer()
                    
                    Text("₹\(cart.total, specifier: "%.0f")")
>>>>>>> 87e46065e2c8ce2b2a8882799c64ab5c91a47b1a:Food_Delivery_App/Features/Address/Views/AddressView.swift
                }
                .font(.title2)
                
                
                NavigationLink {
                    PaymentView()
                } label: {
                    
                    Text("Proceed to payment")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                }
                
                
                Button("Checkout") {
                    
                    guard defaultAddress != nil else {
                        return
                    }
                    
                    orders.placeOrder(
                        items: cart.items.values.map { $0.item },
                        total: cart.total
                    )
                    
                    cart.items.removeAll()
                }
            }
            .padding(.horizontal, 26)
            .padding(.bottom)
            .background(Color(.systemGray6))
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.load()
            }
        }
    }
    
    
    private func deliveryRow(title: String,
                             type: DeliveryType) -> some View {
        
        HStack {
            
            Image(systemName:
                    selectedDelivery == type
                  ? "largecircle.fill.circle"
                  : "circle")
            .foregroundColor(.orange)
            
            
            Text(title)
                .font(.footnote)
            
            
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectedDelivery = type
        }
    }
}



#Preview {
    
    AddressView()
        .environmentObject(CartManager())
        .environmentObject(OrderManager())
    
}

