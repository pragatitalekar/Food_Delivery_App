//
//  PaymentMethodView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/10/26.
//

import SwiftUI

struct PaymentMethodView: View {
    @State private var selectedMethod: PaymentOption = .card
    @State private var showAddCard = false
    @State private var showAddBank = false
    
    enum PaymentOption { case card, bank }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text("Payment method")
                .font(.system(size: 18, weight: .semibold))
                .padding(.horizontal, 24)
            
            VStack(spacing: 0) {
                // Card Option
                PaymentRow(
                    title: "Card",
                    icon: "creditcard.fill",
                    color: .orange,
                    isSelected: selectedMethod == .card,
                    action: { selectedMethod = .card }
                )
                
                Divider().padding(.leading, 70)
                
                // Bank Option
                PaymentRow(
                    title: "Bank account",
                    icon: "building.columns.fill",
                    color: .pink,
                    isSelected: selectedMethod == .bank,
                    action: { selectedMethod = .bank }
                )
            }
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .padding(.horizontal, 24)
            
            // Add Details Button based on selection
            Button(action: {
                if selectedMethod == .card { showAddCard = true }
                else { showAddBank = true }
            }) {
                Text(selectedMethod == .card ? "+ Add New Card" : "+ Add Bank Account")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppColors.primary)
                    .padding(.horizontal, 24)
            }
            
            Spacer()
        }
        .padding(.top, 20)
        .background(Color(.secondarySystemBackground).ignoresSafeArea())
        .navigationTitle("Payment")
        .sheet(isPresented: $showAddCard) { AddDetailsSheet(type: "Card") }
        .sheet(isPresented: $showAddBank) { AddDetailsSheet(type: "Bank Account") }
    }
}

struct PaymentRow: View {
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
                    RoundedRectangle(cornerRadius: 10).fill(color)
                    Image(systemName: icon).foregroundColor(.white)
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

struct AddDetailsSheet: View {
    let type: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("\(type) Details") {
                    if type == "Card" {
                        TextField("Card Number", text: .constant(""))
                        TextField("Expiry Date", text: .constant(""))
                        SecureField("CVV", text: .constant(""))
                    } else {
                        TextField("Account Holder Name", text: .constant(""))
                        TextField("Account Number", text: .constant(""))
                        TextField("IFSC / Swift Code", text: .constant(""))
                    }
                }
            }
            .navigationTitle("Add \(type)")
            .toolbar {
                Button("Save") { dismiss() }
            }
        }
    }
}
struct FAQView: View {
    var body: some View {
        List {
            DisclosureGroup("How do I track my order?") {
                Text("Go to the Orders tab in your profile to see real-time updates.")
                    .font(.subheadline).foregroundColor(.secondary)
            }
            DisclosureGroup("What is the return policy?") {
                Text("You can cancel orders within 5 minutes of placing them.")
                    .font(.subheadline).foregroundColor(.secondary)
            }
        }
        .navigationTitle("FAQ")
    }
}

struct HelpView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "headphones.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(AppColors.primary)
            
            Text("How can we help you?")
                .font(.title2).bold()
            
            Text("Our support team is available 24/7 to assist you with your orders.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {}) {
                Label("Contact Support", systemImage: "message.fill")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppColors.primary)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding()
        }
        .navigationTitle("Help")
    }
}


