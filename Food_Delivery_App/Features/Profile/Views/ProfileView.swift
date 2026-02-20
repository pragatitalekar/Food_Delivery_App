//
//  ProfileView.swift
//  Food_Delivery_App
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var vm = ProfileViewModel()
    @State private var showEditSheet = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            ScrollView {
                
                VStack(spacing: 20) {
                    
                    PersonalDetailsCard(vm: vm) {
                        showEditSheet = true
                    }
                    
                    VStack(spacing: 12) {
                        
                        NavigationLink {
                            PaymentMethodView()
                        } label: {
                            ProfileMenuRow(
                                title: "Payment method",
                                icon: "creditcard.fill"
                            )
                        }
                        
                        NavigationLink {
                            HistoryView()
                        } label: {
                            ProfileMenuRow(
                                title: "Order History",
                                icon: "clock.fill"
                            )
                        }
                        
                        ProfileMenuRow(
                            title: "Pending reviews",
                            icon: "star.fill"
                        )
                        
                        NavigationLink {
                            FAQView()
                        } label: {
                            ProfileMenuRow(
                                title: "FAQ",
                                icon: "questionmark.circle.fill"
                            )
                        }
                        
                        NavigationLink {
                            HelpView()
                        } label: {
                            ProfileMenuRow(
                                title: "Help",
                                icon: "headphones.circle.fill"
                            )
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 20)
            }
            
            VStack {
                
                Button {
                    vm.saveProfile()
                } label: {
                    
                    Text("Update")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(AppColors.primary)
                        .cornerRadius(30)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 72)
            .background(AppColors.background)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("My profile")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showEditSheet) {
            EditProfileSheet(vm: vm)
        }
        .alert(vm.alertMessage, isPresented: $vm.showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}



struct PersonalDetailsCard: View {
    
    @ObservedObject var vm: ProfileViewModel
    let onChangeTap: () -> Void
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 18) {
            
            HStack {
                Text("Personal details")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(AppColors.textPrimary)
                
                Spacer()
                
                Button("Change") {
                    onChangeTap()
                }
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(AppColors.primary)
            }
            
            HStack(alignment: .center, spacing: 16) {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(AppColors.primary.opacity(0.1))
                        .frame(width: 80, height: 80)
                    
                    Image(systemName: "person.fill")
                        .font(.system(size: 34))
                        .foregroundColor(AppColors.primary)
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(vm.name.isEmpty ? "No name added" : vm.name)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text(vm.email)
                        .font(.system(size: 14))
                        .foregroundColor(AppColors.textSecondary)
                    
                    Text(vm.phone.isEmpty ? "No phone added" : vm.phone)
                        .font(.system(size: 14))
                        .foregroundColor(AppColors.textSecondary)
                    
                    Text(vm.address.isEmpty ? "No address added" : vm.address)
                        .font(.system(size: 14))
                        .foregroundColor(AppColors.textSecondary)
                        .lineLimit(2)
                }
                
                Spacer()
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(18)
        .shadow(color: AppColors.shadow
                , radius: 8, x: 0, y: 4)
    }
}



struct ProfileMenuRow: View {
    
    let title: String
    let icon: String
    
    var body: some View {
        
        HStack(spacing: 14) {
            
            Image(systemName: icon)
                .font(.system(size: 17))
                .foregroundColor(AppColors.primary)
                .frame(width: 24)
            
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(AppColors.textPrimary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(AppColors.textSecondary.opacity(0.6))
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(14)
    }
}


struct EditProfileSheet: View {
    
    @ObservedObject var vm: ProfileViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                Section("Personal Information") {
                    
                    TextField("Name", text: $vm.name)
                    
                    TextField("Email", text: $vm.email)
                        .keyboardType(.emailAddress)
                        .disabled(true)
                        .foregroundColor(.gray)
                    
                    TextField("Phone", text: $vm.phone)
                        .keyboardType(.phonePad)
                    
                    TextField("Address", text: $vm.address, axis: .vertical)
                        .lineLimit(3...5)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .background(Color(.systemGray6))
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
