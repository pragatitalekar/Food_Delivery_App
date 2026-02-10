//
//  SecurityView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/8/26.
//

import SwiftUI

struct SecurityView: View {
    
    @Environment(\.dismiss) var dismiss
    
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
                        Text("Account Security")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(AppColors.textPrimary)
                        
                        VStack(spacing: 12) {
                            SecurityOptionRow(title: "Change Password", icon: "key.fill")
                            SecurityOptionRow(title: "Two-Factor Authentication", icon: "shield.fill")
                            SecurityOptionRow(title: "Face ID / Touch ID", icon: "faceid")
                            SecurityOptionRow(title: "Trusted Devices", icon: "iphone")
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Data & Permissions")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(AppColors.textPrimary)
                        
                        VStack(spacing: 12) {
                            SecurityOptionRow(title: "App Permissions", icon: "gearshape.fill")
                            SecurityOptionRow(title: "Data Export", icon: "square.and.arrow.up.fill")
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
            }
        }
        .navigationBarHidden(true)
        .background(AppColors.background.ignoresSafeArea())
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
    SecurityView()
}
