//
//  SecurityView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/8/26.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SecurityView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showDeactivateAlert = false
    @State private var showDeleteAlert = false
    
    @State private var showDeactivateToast = false
    @State private var showDeleteToast = false
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("appTheme") private var appTheme: String = "system"
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(AppColors.textPrimary)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 30) {
                    
                    Text("Security")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                        .padding(.top, 10)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("Account")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(AppColors.textPrimary)
                        
                        VStack(spacing: 12) {
                            
                            NavigationLink {
                                ChangePasswordView()
                            } label: {
                                SecurityOptionRow(
                                    title: "Change Password",
                                    icon: "key.fill"
                                )
                            }
                            .buttonStyle(.plain)
                            
                            Button {
                                showDeactivateAlert = true
                            } label: {
                                SecurityOptionRow(
                                    title: "Deactivate Account",
                                    icon: "pause.circle.fill"
                                )
                            }
                            .buttonStyle(.plain)
                            
                            Button {
                                showDeleteAlert = true
                            } label: {
                                SecurityOptionRow(
                                    title: "Delete Account",
                                    icon: "trash.fill"
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("Appearance")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(AppColors.textPrimary)
                        
                        Picker("App Theme", selection: $appTheme) {
                            Text("System").tag("system")
                            Text("Light").tag("light")
                            Text("Dark").tag("dark")
                        }
                        .pickerStyle(.segmented)
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(15)
                        .shadow(color: AppColors.shadow, radius: 5, x: 0, y: 2)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
            }
        }
        .navigationBarHidden(true)
        .background(AppColors.background.ignoresSafeArea())
        .overlay(toastView, alignment: .top)

        .alert("Deactivate Account?", isPresented: $showDeactivateAlert) {
            Button("Cancel", role: .cancel) { }
            
            Button("Deactivate", role: .destructive) {
                deactivateAccount()
            }
        } message: {
            Text("You can reactivate your account later by logging in again.")
        }
        
        .alert("Delete Account?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            
            Button("Delete", role: .destructive) {
                deleteAccount()
            }
        } message: {
            Text("This action is permanent. Your account cannot be recovered.")
        }
    }

    private var toastView: some View {
        VStack {
            if showDeactivateToast {
                Text("Your account has been deactivated")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.85))
                    .cornerRadius(12)
                    .padding(.top, 60)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            
            if showDeleteToast {
                Text("Account deleted successfully")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(12)
                    .padding(.top, 60)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            
            Spacer()
        }
        .animation(.easeInOut, value: showDeactivateToast)
        .animation(.easeInOut, value: showDeleteToast)
    }

    private func deactivateAccount() {
        guard let user = Auth.auth().currentUser else { return }
        
        Firestore.firestore()
            .collection("users")
            .document(user.uid)
            .setData(["isActive": false], merge: true) { error in
                
                if error == nil {
                    try? Auth.auth().signOut()
                    
                    DispatchQueue.main.async {
                        withAnimation {
                            showDeactivateToast = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            dismiss()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                isLoggedIn = false
                            }
                        }
                    }
                }
            }
    }

    private func deleteAccount() {
        guard let user = Auth.auth().currentUser else { return }
        let uid = user.uid
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .delete { error in
                
                if error == nil {
                    
                    user.delete { deleteError in
                        
                        if deleteError == nil {
                            DispatchQueue.main.async {
                                withAnimation {
                                    showDeleteToast = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    dismiss()
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        isLoggedIn = false
                                    }
                                }
                            }
                        }
                    }
                }
            }
    }
}

struct SecurityOptionRow: View {
    
    let title: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(AppColors.primary)
                .frame(width: 24)
            
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColors.textPrimary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(AppColors.textSecondary.opacity(0.5))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: AppColors.shadow, radius: 5, x: 0, y: 2)
    }
}

#Preview {
    NavigationStack {
        SecurityView()
    }
}
