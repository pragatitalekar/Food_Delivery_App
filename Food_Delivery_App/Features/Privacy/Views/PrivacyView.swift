//
//  PrivacyView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/8/26.
//
import SwiftUI

struct PrivacyView: View {
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
                VStack(alignment: .leading, spacing: 25) {
                    Text("Privacy policy")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                        .padding(.top, 10)
                    
                    
                    VStack(spacing: 16) {
                        PrivacyAccordion(
                            title: "Information We Collect",
                            content: "We collect information you provide directly to us when you create an account, place an order, or communicate with us."
                        )
                        
                        PrivacyAccordion(
                            title: "How We Use Information",
                            content: "We use the information we collect to provide, maintain, and improve our services, such as processing your transactions and sending you related information."
                        )
                        
                        PrivacyAccordion(
                            title: "Sharing of Information",
                            content: "We do not share your personal information with third parties except as described in this policy, such as with delivery partners to fulfill your order."
                        )
                        
                        PrivacyAccordion(
                            title: "Your Rights",
                            content: "You have the right to access, correct, or delete your personal data. You can manage most of this information through your profile settings."
                        )
                        
                        PrivacyAccordion(
                            title: "Security of Data",
                            content: "We use commercially reasonable security measures to protect your information, though no method of transmission over the internet is 100% secure."
                        )
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

struct PrivacyAccordion: View {
    let title: String
    let content: String
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            DisclosureGroup(isExpanded: $isExpanded) {
                Text(content)
                    .font(.system(size: 15))
                    .foregroundColor(AppColors.textSecondary)
                    .lineSpacing(4)
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } label: {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(AppColors.textPrimary)
                    .padding(.vertical, 4)
            }
            .accentColor(AppColors.primary)
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: AppColors.shadow, radius: 8, x: 0, y: 4)
    }
}
#Preview {
    PrivacyView()
}
