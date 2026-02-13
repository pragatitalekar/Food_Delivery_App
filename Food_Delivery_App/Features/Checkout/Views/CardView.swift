//
//  CardView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/10/26.
//

import SwiftUI

struct CardView<Content: View> : View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(AppColors.background)
            .cornerRadius(16)
            .shadow(color: AppColors.shadow
                    , radius: 8, x: 0, y: 4)
    }
}
