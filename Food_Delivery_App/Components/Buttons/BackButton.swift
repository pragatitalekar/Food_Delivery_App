//
//  BackButton.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/8/26.
//

import SwiftUI

struct BackButton: View {
    
    var title: String
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        
        Button {
            
            if !navigationManager.path.isEmpty {
                navigationManager.path.removeLast()
            }
            
        } label: {
            
            HStack(spacing: 8) {
                
                Image(systemName: "arrow.left")
                    .font(.system(size: 18, weight: .semibold))
                
                Text(title)
                    .font(.system(size: 18, weight: .medium))
                
            }
            .foregroundColor(.black)
            
        }
        
    }
}
