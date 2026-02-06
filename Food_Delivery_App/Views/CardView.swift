//
//  CardView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/5/26.
//

import SwiftUI

struct CardView<Content : View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemGray5))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
            
    }
}


