//
//  HomeView.swift
//  Food_Delivery_App
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @Binding var showSideMenu: Bool
    
    @Namespace private var underlineAnimation
    
    @StateObject private var vm = HomeViewModel()
    
    @EnvironmentObject var cart: CartManager
    
    @State private var selected: CategoryType = .meals
    
    
    var filtered: [FoodItems] {
        vm.allItems.filter { $0.category == selected }
    }
    
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 20) {
                
                // MARK: HEADER
                
                HStack {
                    
                    Button {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            showSideMenu = true
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(AppColors.textPrimary)
                    }
                    
                    
                    Spacer()
                    
                    
                    NavigationLink {
                        CartView()
                    } label: {
                        Image(systemName: "cart")
                            .font(.title2)
                            .foregroundColor(AppColors.textPrimary)
                    }
                }
                
                
                // MARK: TITLE
                
                Text("Delicious Food\nFor You")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.textPrimary)
                
                
                // MARK: SEARCH
                
                NavigationLink {
                    SearchView(homeVM: vm)
                } label: {
                    
                    HStack {
                        
                        Image(systemName: "magnifyingglass")
                        
                        Text("Search")
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(15)
                }
                
                
                // MARK: CATEGORY
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 24) {
                        
                        ForEach(CategoryType.allCases, id: \.self) { category in
                            
                            VStack(spacing: 6) {
                                
                                Button {
                                    withAnimation(.easeInOut(duration: 0.25)) {
                                        selected = category
                                    }
                                } label: {
                                    
                                    Text(category.rawValue)
                                        .foregroundColor(
                                            selected == category
                                            ? .orange
                                            : .gray
                                        )
                                        .fontWeight(.medium)
                                }
                                
                                
                                ZStack {
                                    
                                    if selected == category {
                                        
                                        Rectangle()
                                            .fill(Color.orange)
                                            .frame(height: 3)
                                            .matchedGeometryEffect(
                                                id: "underline",
                                                in: underlineAnimation
                                            )
                                    }
                                    
                                    else {
                                        
                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(height: 3)
                                    }
                                }
                            }
                        }
                    }
                }
                
                
                // MARK: SEE MORE
                
                NavigationLink("see more") {
                    CategoryListView(items: filtered)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(.orange)
                
                
                // MARK: FOOD LIST
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 30) {
                        
                        ForEach(filtered.prefix(6)) { item in
                            
                            NavigationLink {
                                
                                DetailView(item: item)
                                
                            } label: {
                                
                                ItemCard(item: item)
                            }
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
            
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        
        .onAppear {
            vm.fetchAll()
        }
    }
}



#Preview {
    
    NavigationStack {
        
        HomeView(showSideMenu: .constant(false))
            .environmentObject(CartManager())
    }
}
