//
//  BadgeView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import SwiftUI

struct BadgeView: View {
    
    let count: Int
    
    var body: some View {
        
        if count > 0 {
            
            Text("\(count)")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background(AppColors.primary)
                .clipShape(Capsule())
                .fixedSize()
                .transition(.scale)
        }
        
    }
}

#Preview {
    
    ZStack {
        
        Image(systemName: "cart")
            .font(.largeTitle)
        
        BadgeView(count: 3)
            .offset(x: 12, y: -12)
        
    }
    
}

