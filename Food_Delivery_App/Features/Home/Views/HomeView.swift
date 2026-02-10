//
//  HomeView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

//
//  HomeView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @Namespace private var underlineAnimation
    @StateObject var vm = HomeViewModel()
    @EnvironmentObject var cart: CartManager
    @State private var selected: CategoryType = .meals
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    var filtered: [FoodItems] {
        vm.allItems.filter { $0.category == selected }
    }
    
    var body: some View {
        
        NavigationStack {
            
            GeometryReader { geo in
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Button {
                            navigationManager.showSideMenu = true
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .font(.title)
                                .foregroundColor(AppColors.textPrimary)
                        }
                        
                        
                        NavigationLink{
                            CartView()
                            
                        }label: {
                            Image(systemName: "cart")
                                .font(.title)
                                .foregroundStyle(AppColors.textPrimary)
                        }
                        
                        .padding(6)
                        .offset(x:300,y: -50)
                        
                        
                        
                        Text("Delicious Food\nFor You")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(AppColors.textPrimary)
                        
                        NavigationLink {
                            SearchView(homeVM: vm)
                        } label: {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                Text("Search")
                                Spacer()
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(15)
                        }
                        
                    
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 24) {
                                ForEach(CategoryType.allCases, id: \.self) { cat in
                                    
                                    VStack(spacing: 6) {
                                        
                                        Button {
                                            withAnimation(.easeInOut(duration: 0.25)) {
                                                selected = cat
                                            }
                                        } label: {
                                            Text(cat.rawValue)
                                                .foregroundColor(selected == cat ? .orange : .gray)
                                                .fontWeight(.medium)
                                        }
                                        
                                        ZStack {
                                            if selected == cat {
                                                Rectangle()
                                                    .fill(Color.orange)
                                                    .frame(height: 3)
                                                    .matchedGeometryEffect(
                                                        id: "underline",
                                                        in: underlineAnimation
                                                    )
                                            } else {
                                                Rectangle()
                                                    .fill(Color.clear)
                                                    .frame(height: 3)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                        
                        NavigationLink("see more") {
                            CategoryListView(items: filtered)
                        }.frame(maxWidth: .infinity, alignment: .trailing)
                            .foregroundStyle(.orange)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack (spacing: 30){
                                ForEach(filtered.prefix(6)) { item in
                                    NavigationLink {
                                        DetailView(item: item)
                                    } label: {
                                        ItemCard(item: item)
                                    }
                                }
                            }
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .frame(width: geo.size.width, alignment: .leading)
                    
                    
                }
                .onAppear {
                    vm.fetchAll()
                }
                .background(Color(.systemGray6))
                
                
            }
            
            
        }
    }
    
}

#Preview {
    HomeView()
        .environmentObject(NavigationManager.shared)
}
