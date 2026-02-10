//
//  ProfileView.swift
//  Food_Delivery_App
//
//  Created by Bhaswanth on 2/6/26.
//


import SwiftUI

import SwiftUI

struct ProfileView: View {
    @State private var name = "Bhaswanth"
    @State private var email = "bhaswanth@gmail.com"
    @State private var phone = "+91 9876543210"
    @State private var address = "MG Road Bangalore 560016"
    @State private var showEditSheet = false
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    PersonalDetailsCard(
                        name: name,
                        email: email,
                        phone: phone,
                        address: address,
                        onChangeTap: { showEditSheet = true }
                    )
                    
                    VStack(spacing: 12) {
                        
                        NavigationLink(destination: PaymentMethodView()) {
                            ProfileMenuRow(title: "Payment method", icon: "creditcard.fill")
                        }
                        
                        NavigationLink(destination: Text("Orders View")) {
                            ProfileMenuRow(title: "Orders", icon: "bag.fill")
                        }
                        
                        ProfileMenuRow(title: "Pending reviews", icon: "star.fill")
                        
                        
                        NavigationLink(destination: FAQView()) {
                            ProfileMenuRow(title: "Faq", icon: "questionmark.circle.fill")
                        }
                        
                        NavigationLink(destination: HelpView()) {
                            ProfileMenuRow(title: "Help", icon: "headphones.circle.fill")
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
            }
            
            PrimaryButton(title: "Update")
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("My profile")
        .sheet(isPresented: $showEditSheet) {
            EditProfileSheet(name: $name, email: $email, phone: $phone, address: $address)
        }
    }
}

struct PersonalDetailsCard: View {
    
    let name: String
    let email: String
    let phone: String
    let address: String
    let onChangeTap: () -> Void
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            HStack {
                
                Text("Personal details")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppColors.textPrimary)
                
                Spacer()
                
                Button("change") {
                    onChangeTap()
                }
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.primary)
            }
            
            HStack(spacing: 14) {
                
                ZStack {
                    
                    Circle()
                        .fill(AppColors.primary.opacity(0.15))
                        .frame(width: 64, height: 64)
                    
                    Image(systemName: "person.fill")
                        .font(.system(size: 28))
                        .foregroundColor(AppColors.primary)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text(name)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text(email)
                        .font(.system(size: 13))
                        .foregroundColor(AppColors.textSecondary)
                    
                    Text(phone)
                        .font(.system(size: 13))
                        .foregroundColor(AppColors.textSecondary)
                    
                    Text(address)
                        .font(.system(size: 13))
                        .foregroundColor(AppColors.textSecondary)
                        .lineLimit(2)
                }
                
                Spacer()
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.systemBackground))
            )
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

struct ProfileMenuRow: View {
    
    let title: String
    let icon: String
    
    var body: some View {
        
        HStack(spacing: 14) {
            
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(AppColors.primary)
                .frame(width: 24)
            
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(AppColors.textPrimary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(AppColors.textSecondary.opacity(0.6))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(.systemBackground))
        )
    }
}

struct EditProfileSheet: View {
    
    @Binding var name: String
    @Binding var email: String
    @Binding var phone: String
    @Binding var address: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                Section("Personal Information") {
                    
                    TextField("Name", text: $name)
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                    
                    TextField("Phone", text: $phone)
                        .keyboardType(.phonePad)
                    
                    TextField("Address", text: $address, axis: .vertical)
                        .lineLimit(3...5)
                }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    
    NavigationStack {
        ProfileView()
    }
}
