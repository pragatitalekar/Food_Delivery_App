//
//  PaymentView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import SwiftUI

struct PaymentView: View {
    
    
    @State private var selectedDelivery: DeliveryType = .door
    
    @State private var selectPayment: PaymentType = .card
    
    
    enum PaymentType {
            case card
            case bankAccount
    }
    
    enum DeliveryType {
        case door
        case pickup
    }
    
    
    
    var body: some View {
        NavigationStack {
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
                            paymentRow(title: "Door delivery",
                                       
                                       type: .card)
                            
                            Divider()
                            
                            paymentRow(title: "Pick up",
                                     
                                       type: .bankAccount)
                        }
                        .padding(6)	
                    }
                    
                }
                
                
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Delivery method")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    
                    CardView {
                        VStack(spacing: 16) {
                            deliveryRow(title: "Card", type: .door)
                            
                            Divider()
                            
                            deliveryRow(title: "Bank Account", type: .pickup)
                        }
                        .padding(6)
                    }
                    
                }
                
                
                
                Spacer()
                
                
                HStack {
                    Text("Total")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Text("23,000")
                        .font(.headline)
                }
                
                
                NavigationLink {
                    CheckoutView()
                    
                } label: {
                    Text("Checkout")
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
        }
    }
    
    private func paymentRow(title: String, type: PaymentType) -> some View {
        HStack {
            Image(systemName: selectPayment == type
                  ? "largecircle.fill.circle"
                  : "circle")
            .foregroundColor(.orange)
            
            Text(title)
                .font(.footnote)
            
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectPayment = type
        }
    }
}


#Preview {
    PaymentView()
}
