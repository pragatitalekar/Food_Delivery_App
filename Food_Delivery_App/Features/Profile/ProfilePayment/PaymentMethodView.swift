//
//  PaymentMethodView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/10/26.
//

import SwiftUI

struct PaymentMethodView: View {
    
    @StateObject private var vm = PaymentViewModel()
    @State private var showAdd = false
    @State private var editMethod: PaymentMethod?
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 30) {
                
                Text("Payment")
                    .font(.system(size: 34, weight: .bold))
                
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Payment method")
                        .font(.headline)
                    
                    
                    VStack(spacing: 0) {
                        
                        PaymentSelectionRow(
                            title: "Card",
                            icon: "creditcard.fill",
                            color: .orange,
                            isSelected: vm.selectedType == "Card"
                        ) {
                            vm.selectedType = "Card"
                        }
                        
                        Divider()
                            .padding(.leading, 60)
                        
                        PaymentSelectionRow(
                            title: "Bank account",
                            icon: "building.columns.fill",
                            color: .pink,
                            isSelected: vm.selectedType == "Bank account"
                        ) {
                            vm.selectedType = "Bank account"
                        }
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                }
                
                
                if !vm.methods.isEmpty {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text("Saved payment options")
                            .font(.headline)
                        
                        
                        ForEach(vm.methods) { method in
                            
                            SavedMethodCard(
                                method: method,
                                onEdit: {
                                    editMethod = method
                                },
                                onDelete: {
                                    vm.delete(id: method.id)
                                }
                            )
                        }
                    }
                }
                
                
                Button(action: {
                    showAdd = true
                }) {
                    
                    Text("Add New Method")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(12)
                }
                .padding(.top, 20)
            }
            .padding(20)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .onAppear {
            vm.load()
        }
        .sheet(isPresented: $showAdd) {
            
            AddPaymentView {
                vm.load()
            }
        }
        .sheet(item: $editMethod) { method in
            
            AddPaymentView(existingMethod: method) {
                vm.load()
            }
        }
    }
}



struct PaymentSelectionRow: View {
    
    let title: String
    let icon: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            
            HStack(spacing: 16) {
                
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(isSelected ? .orange : .gray)
                
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(color)
                    
                    Image(systemName: icon)
                        .foregroundColor(.white)
                }
                .frame(width: 40, height: 40)
                
                
                Text(title)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding()
        }
    }
}



struct SavedMethodCard: View {
    
    let method: PaymentMethod
    var onEdit: (() -> Void)?
    var onDelete: (() -> Void)?
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(method.type == "Card" ? Color.orange.opacity(0.1) : Color.pink.opacity(0.1))
                
                Image(systemName: method.type == "Card" ? "creditcard.fill" : "building.columns.fill")
                    .foregroundColor(method.type == "Card" ? .orange : .pink)
            }
            .frame(width: 50, height: 50)
            
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(method.holderName)
                    .font(.system(size: 16, weight: .semibold))
                
                Text(maskedNumber(method.number))
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            
            Spacer()
            
            
            Menu {
                
                Button {
                    onEdit?()
                } label: {
                    Label("Edit", systemImage: "pencil")
                }
                
                
                Button(role: .destructive) {
                    onDelete?()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                
            } label: {
                
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.gray)
                    .frame(width: 40, height: 40)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
    }
    
    
    private func maskedNumber(_ number: String) -> String {
        
        guard number.count > 4 else {
            return number
        }
        
        return "**** \(number.suffix(4))"
    }
}



#Preview {
    PaymentMethodView()
}
