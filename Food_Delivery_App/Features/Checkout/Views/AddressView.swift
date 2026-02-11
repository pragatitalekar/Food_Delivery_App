//
//  AddressView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//



import SwiftUI
import Combine


struct AddressView: View {
    
    @State private var selectedDelivery: DeliveryType = .door
    
    enum DeliveryType {
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
                        }
                        .font(.footnote)
                        .foregroundColor(.orange)
                    }
                    
                    CardView {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Encora")
                                .font(.headline)
                            
                            Text("Brigade South Parade 10 Mahatma Gandhi RdYellappa Garden Yellappa Chetty Layout Sivanchetti Gardens Bengaluru Karnataka 560001")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            
                            Text("+91 9011039271")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                //.frame(maxWidth: .infinity, alignment: .leading)
                
                
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
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Text("23,000")
                        .font(.headline)
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
}

#Preview {
    AddressView()
}
