//
//  OffersView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import SwiftUI

struct OffersView: View {
    
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
            
            VStack(alignment: .leading, spacing: 0) {
               
                Text("My offers")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                    .padding(.horizontal, 24)
                    .padding(.top, 10)
                
                Spacer()
                
                
                VStack(spacing: 12) {
                    Text("ohh snap! No offers yet")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(AppColors.textPrimary)
                        .multilineTextAlignment(.center)
                    
                    Text("Bella doesn't have any offers\nyet please check again.")
                        .font(.system(size: 17))
                        .foregroundColor(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 40)
                
                Spacer()
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .background(AppColors.background.ignoresSafeArea())
    }
}

#Preview {
    OffersView()
}
