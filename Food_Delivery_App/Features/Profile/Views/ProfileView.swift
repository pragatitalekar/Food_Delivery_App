//
//  ProfileView.swift
//  Food_Delivery_App
//
//  Created by Bhaswanth on 2/6/26.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        
        ZStack {
            
            AppColors.background
                .ignoresSafeArea()
            
            Text("Profile Screen")
                .font(.largeTitle)
                .foregroundColor(AppColors.textPrimary)
            
        }
        
    }
    
}
#Preview {
    
}
