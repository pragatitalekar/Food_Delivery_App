//
//  HomeView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        
        NavigationStack {
            
            GeometryReader { geo in
                
                ScrollView(.vertical) {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // MARK: - Hamburger Button
                        
                        Button {
                            navigationManager.showSideMenu = true
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .font(.title)
                                .foregroundColor(AppColors.textPrimary)
                        }
                        
                        
                        // MARK: - Title
                        
                        Text("Delicious Food\nFor You")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(AppColors.textPrimary)
                        
                        
                        // MARK: - Search Bar
                        
                       
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(AppColors.textSecondary)
                            
                            Text("Search")
                                .foregroundColor(AppColors.textSecondary)
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemFill))  
                        .cornerRadius(12)
                        
                        
                        // MARK: - Categories
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack(spacing: 25) {
                                
                                Text("Food")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(AppColors.textPrimary)
                                
                                
                                Text("Drinks")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(AppColors.textPrimary)
                                
                                
                                Text("Snacks")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(AppColors.textPrimary)
                                
                            }
                            
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .frame(
                        width: geo.size.width,
                        alignment: .leading
                    )
                    
                    
                    Spacer()
                    
                }
                
            }
            
        }
        
    }
    
}

#Preview {
    HomeView()
        .environmentObject(NavigationManager.shared)
}
