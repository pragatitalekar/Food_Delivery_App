//
//  PaymentView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import SwiftUI

struct PaymentView: View {
    
    @EnvironmentObject var cart: CartManager
    
    @State private var orderNote = false
    
    @State private var selectedDelivery: DeliveryType =
        DeliveryType(rawValue: PersistenceService.shared.loadDelivery()) ?? .door
    
    @State private var selectPayment: PaymentType =
        PaymentType(rawValue: PersistenceService.shared.loadPayment()) ?? .card
    
    enum PaymentType: String {
        case card
        case bankAccount
    }
    
    enum DeliveryType: String {
        case door
        case pickup
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                VStack(spacing: 32) {
                    
                    Text("Payment")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Payment method")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        CardView {
                            VStack(spacing: 16) {
                                paymentRow(title: "Card",
                                           icon: "creditcard",
                                           iconColor: .orange,
                                           type: .card)
                                
                                Divider()
                                
                                paymentRow(title: "Bank Account",
                                           icon: "building.columns",
                                           iconColor: .pink,
                                           type: .bankAccount)
                            }
                            .padding(6)
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("Total")

                        Spacer()

                        Text("₹\(cart.total, specifier: "%.0f")")
                       
                    }
                    .font(.title2)
                    
                    Button {
                        orderNote = true
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
                
                if orderNote {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            orderNote = false
                        }
                    
                    CheckoutView(
                        address: PersistenceService.shared.loadAddress()?.name ?? "No Address",
                        deliveryType: selectedDelivery.rawValue,
                        paymentType: selectPayment.rawValue,
                        onCancel: {
                            orderNote = false
                        },
                        onProceed: {
                            orderNote = false
                        }
                    )
                }
            }
        }
    }
    
    private func paymentRow(title: String, icon: String, iconColor: Color, type: PaymentType) -> some View {
        HStack {
            Image(systemName: selectPayment == type
                  ? "largecircle.fill.circle"
                  : "circle")
                .foregroundColor(.orange)
            
            Image(systemName: icon)
                .foregroundColor(.white)
                .padding(8)
                .background(iconColor)
                .cornerRadius(12)
            
            Text(title)
                .font(.footnote)
            
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectPayment = type
            PersistenceService.shared.savePayment(type.rawValue)
        }
    }
}


#Preview {
    PaymentView()
        .environmentObject(CartManager())
}
