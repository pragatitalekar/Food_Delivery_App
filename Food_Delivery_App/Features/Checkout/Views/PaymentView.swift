//
//  PaymentView.swift
//  Food_Delivery_App
//

import SwiftUI

struct PaymentView: View {
    
    @EnvironmentObject var cart: CartManager
    
    @StateObject private var vm = PaymentViewModel()
    @StateObject private var addressVM = AddressViewModel()
    
    @State private var selectedMethod: PaymentMethod?
    @State private var orderNote = false
    
    private var defaultAddress: UserAddress? {
        addressVM.addresses.first(where: { $0.isDefault })
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
                                
                                if vm.methods.isEmpty {
                                    
                                    Text("No payment methods added")
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                
                                ForEach(vm.methods) { method in
                                    paymentRow(method: method)
                                }
                                
                                Divider()
                                
                                NavigationLink {
                                    PaymentMethodView()
                                } label: {
                                    
                                    HStack {
                                        
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(.orange)
                                        
                                        Text("Add New Payment Method")
                                            .foregroundColor(.orange)
                                        
                                        Spacer()
                                    }
                                    .padding(.vertical, 8)
                                }
                            }
                            .padding(6)
                        }
                    }
                    
                    
                    Spacer()
                    
                    
                    HStack {
                        
                        Text("Total")
<<<<<<< HEAD
                        Spacer()
=======
                        
                        Spacer()
                        
>>>>>>> 87e46065e2c8ce2b2a8882799c64ab5c91a47b1a
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
                .onAppear {
                    
                    vm.load {
                        if selectedMethod == nil {
                            selectedMethod = vm.methods.first
                        }
                    }
                    
                    addressVM.load()
                }
                
                
                if orderNote {
                    
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            orderNote = false
                        }
                    
                    
                    CheckoutView(
                        address: defaultAddress?.street ?? "No Address",
                        deliveryType: defaultAddress?.fullName ?? "",
                        paymentType: selectedMethodDisplay(),
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
    
    
    private func paymentRow(method: PaymentMethod) -> some View {
        
        HStack {
            
            Image(systemName:
                    selectedMethod?.id == method.id
                  ? "largecircle.fill.circle"
                  : "circle")
                .foregroundColor(.orange)
            
            
            Image(systemName:
                    method.type == "Card"
                  ? "creditcard.fill"
                  : "building.columns.fill")
                .foregroundColor(.white)
                .padding(8)
                .background(method.type == "Card" ? Color.orange : Color.pink)
                .cornerRadius(12)
            
            
            VStack(alignment: .leading) {
                
                Text(method.holderName)
                    .font(.footnote)
                
                Text(maskedNumber(method.number))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectedMethod = method
        }
    }
    
    
    private func selectedMethodDisplay() -> String {
        
        guard let method = selectedMethod else {
            return "No payment selected"
        }
        
        return "\(method.type) •••• \(method.number.suffix(4))"
    }
    
    
    private func maskedNumber(_ number: String) -> String {
        
        guard number.count > 4 else { return number }
        return "**** \(number.suffix(4))"
    }
}


#Preview {
    PaymentView()
        .environmentObject(CartManager())
}
