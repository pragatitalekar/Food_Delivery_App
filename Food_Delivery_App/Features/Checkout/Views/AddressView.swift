//
//  AddressView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//



import SwiftUI


struct AddressView: View {
    
    
    @EnvironmentObject var cart: CartManager
    
    @StateObject private var viewModel = AddressViewModel()
    @State private var showEditSheet = false
    
    @State private var selectedDelivery: DeliveryType =
        DeliveryType(rawValue: PersistenceService.shared.loadDelivery()) ?? .door
    
    enum DeliveryType: String {
        case door
        case pickup
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                
                Text("Delivery")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
             
                VStack(alignment: .leading, spacing: 15) {
                    
                    HStack {
                        Text("Address details")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        Button("change") {
                            showEditSheet = true
                        }
                        .font(.footnote)
                        .foregroundColor(.orange)
                    }
                    
                    CardView {
                        
                        if viewModel.isEmpty {
                            VStack(alignment: .leading) {
                                Text("No address added")
                                    .font(.headline)
                                
                                Text("Tap change to add address")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        } else {
                            VStack(alignment: .leading, spacing: 16) {
                                Text(viewModel.name)
                                    .font(.headline)
                                
                                Text(viewModel.street)
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                
                                Text(viewModel.phone)
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
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
                    Text("Total ₹\(cart.total, specifier: "%.0f")")
                        .font(.title2)

                }
                
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
            }
            .padding(.horizontal, 26)
            .padding(.bottom)
            .background(Color(.systemGray6))
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showEditSheet) {
                EditAddressView(viewModel: viewModel)
            }
        }
    }
    
    private func deliveryRow(title: String, type: DeliveryType) -> some View {
        HStack {
            Image(systemName: selectedDelivery == type
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
            PersistenceService.shared.saveDelivery(type.rawValue)
        }
    }
}


