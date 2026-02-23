//
//  HomeView .swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/19/26.
//


import SwiftUI

struct HomeView: View {
    
    @Binding var showSideMenu: Bool
    @Namespace private var underlineAnimation
    @StateObject private var vm = HomeViewModel()
    
    @EnvironmentObject var cart: CartManager
    @EnvironmentObject var orderManager: OrderManager
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    @State private var selectedCategory: CategoryType = .meals
    @State private var selectedTab: TabType = .home
    @State private var showSuccessPopup = false
    @State private var goToOrders = false  
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            TabView(selection: $selectedTab) {
                
                NavigationStack {
                    homeMainContent
                }
                .tag(TabType.home)
                
                NavigationStack {
                    FavouriteView()
                }
                .tag(TabType.favourites)
                
                NavigationStack {
                    ProfileView()
                }
                .tag(TabType.profile)
                
                NavigationStack {
                    OrdersView(selectedTab: $selectedTab)
                }
                .tag(TabType.orders)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .background(Color(.systemGray6).ignoresSafeArea())
            
            CustomBottomBar(selectedTab: $selectedTab)
            
           
            OrderSuccessPopup(show: $showSuccessPopup) {
                goToOrders = true
            }
        }
        .onAppear {
            if vm.allItems.isEmpty {
                vm.fetchAll()
            }
        }
        .overlay {
        if vm.showNoInternet {
        NoInternetView()
        }
        }
        .overlay(alignment: .bottom) {
        if isLoggedIn &&
        !orderManager.activeOrders.isEmpty &&
        (selectedTab == .home || selectedTab == .orders) {

        ActiveOrderCard(order: orderManager.activeOrders.first!)
        .padding(.bottom, 90)
        }
        }
    }
    
    // MARK: HOME CONTENT
    private var homeMainContent: some View {
        
        VStack(alignment: .leading, spacing: 18) {
            
            // Hidden NavigationLink
            NavigationLink(
                destination: OrdersView(selectedTab: $selectedTab),
                isActive: $goToOrders
            ) {
                EmptyView()
            }
            .hidden()
            
            // HEADER
            HStack {
                Button {
                    withAnimation(.spring()) {
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
                    ZStack(alignment: .topTrailing) {
                        Image(systemName: "cart")
                            .font(.title2)
                            .foregroundColor(AppColors.textPrimary)
                        
                        if cart.cartCount > 0 {
                            Text("\(cart.cartCount)")
                                .font(.caption2)
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color.orange)
                                .clipShape(Circle())
                                .offset(x: 8, y: -5)
                        }
                    }
                }
            }
            .padding(.horizontal, 28)
            .padding(.top, 20)
            
            Text("Delicious\nfood for you")
                .font(.system(size: 34, weight: .bold))
                .lineSpacing(3)
                .padding(.horizontal, 28)
            
            NavigationLink {
                SearchView(homeVM: vm)
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    Text("Search")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.horizontal, 18)
                .frame(height: 46)
                .background(Color(.systemGray5))
                .cornerRadius(25)
            }
            .padding(.horizontal, 28)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 22) {
                    ForEach(CategoryType.allCases, id: \.self) { category in
                        VStack(spacing: 6) {
                            Button {
                                withAnimation(.easeInOut) {
                                    selectedCategory = category
                                }
                            } label: {
                                Text(category.rawValue)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(selectedCategory == category ? .orange : .gray)
                            }
                            
                            Rectangle()
                                .fill(Color.orange)
                                .frame(height: 3)
                                .opacity(selectedCategory == category ? 1 : 0)
                        }
                    }
                }
                .padding(.horizontal, 28)
            }
            
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        categorySection(title: "Foods", category: .meals)
                        categorySection(title: "Drinks", category: .drinks)
                        categorySection(title: "Snacks", category: .snacks)
                        categorySection(title: "Desserts", category: .desserts)
                    }
                    .padding(.horizontal, 28)
                    .padding(.bottom, 140)
                }
                .onChange(of: selectedCategory) { value in
                    withAnimation(.easeInOut) {
                        proxy.scrollTo(value, anchor: .top)
                    }
                }
            }
        }
        .background(Color(.systemGray6))
    }
    
    private func categorySection(title: String, category: CategoryType) -> some View {
        
        let items = vm.allItems.filter { $0.category == category }
        
        return VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Text(title)
                    .font(.title3)
                    .bold()
                
                Spacer()
                
                NavigationLink("see more") {
                    CategoryListView(items: items)
                }
                .font(.footnote)
                .foregroundColor(.orange)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 26) {
                    ForEach(items.prefix(6)) { item in
                        NavigationLink {
                            DetailView(item: item)
                        } label: {
                            ItemCard(item: item)
                        }
                    }
                }
                .padding(.vertical, 16)
            }
        }
        .id(category)
    }
}
