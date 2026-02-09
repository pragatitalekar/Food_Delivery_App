//
//  HomeView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import SwiftUI
import Combine

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
      @StateObject var cart = CartManager()
      @State private var selected: CategoryType = .meals

      var filtered: [FoodItems] {
          vm.allItems.filter { $0.category == selected }
      }
    
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
                        
                       
                        NavigationLink {
                                           SearchView()
                                       } label: {
                                           HStack {
                                               Image(systemName: "magnifyingglass")
                                                   .foregroundColor(.gray)
                                               
                                               Text("Search")
                                                   .foregroundColor(.gray)
                                               
                                               Spacer()
                                           }
                                           .padding()
                                           .background(Color(.systemGray6))
                                           .cornerRadius(15)
                                           .offset(x: -5,y:-0)
                                       }
                        
                        
                        // MARK: - Categories
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack {
                                
                                ForEach(CategoryType.allCases, id: \.self) { cat in
                                    Button(cat.rawValue) {
                                        selected = cat
                                    }
                                    .padding()
                                    .background(selected == cat ? .orange : .gray.opacity(0.2))
                                    .cornerRadius(12)
                                    
                                }
                            }
                            .padding(.horizontal)
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
