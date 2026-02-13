//
//  PrimaryButton.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    
    var body: some View {
        Button(action: {
            // TODO: Add your action here (e.g., save profile, confirm order)
            print("\(title) button tapped")
        }) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(AppColors.primary)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain) 
    }
}

#Preview {
    PrimaryButton(title: "Update")
        .padding()
        .background(AppColors.background)
}
