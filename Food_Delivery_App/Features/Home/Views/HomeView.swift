import SwiftUI

struct HomeView: View {
    
    @Binding var showSideMenu: Bool
    @Namespace private var underlineAnimation
    @StateObject private var vm = HomeViewModel()
    
    @EnvironmentObject var cart: CartManager
    @EnvironmentObject var orderManager: OrderManager
    
    @State private var selectedCategory: CategoryType = .meals
    @State private var showSuccessPopup = false
    
    var filtered: [FoodItems] {
        vm.allItems.filter { $0.category == selectedCategory }
    }
    
    var body: some View {
        
        TabView {
            
            NavigationStack {
                homeMainContent
                    .overlay(
                        OrderSuccessPopup(show: $showSuccessPopup)
                    )
            }
            .tabItem {
                Image(systemName: Constants.homeIconString)
            }
            
            NavigationStack {
                FavouriteView(allItems: vm.allItems)
            }
            .tabItem {
                Image(systemName: Constants.likedIconString)
            }
            
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Image(systemName: Constants.profileIconString)
            }
            
            NavigationStack {
                OrdersView()
            }
            .tabItem {
                Image(systemName: Constants.ordersIconString)
            }
            
        }
        .tint(.orange)
        .background(Color(.systemGray6).ignoresSafeArea())
        .onAppear {
            
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(Color(.systemGray6))
            appearance.shadowColor = .clear
            
            UITabBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
            
            vm.fetchAll()
        }
    }
    
    
    // MARK: HOME CONTENT
    private var homeMainContent: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 20) {
                
                // ACTIVE ORDER CARD
                if !orderManager.activeOrders.isEmpty {
                    ActiveOrderCard(order: orderManager.activeOrders.first!)
                        .padding(.top, 10)
                }
                
                // TOP BAR
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
                        ZStack(alignment: .topTrailing) {
                            
                            Image(systemName: "cart")
                                .font(.title2)
                                .foregroundColor(AppColors.textPrimary)
                            
                            if cart.cartCount > 0 {
                                BadgeView(count: cart.cartCount)
                                    .offset(x: 10, y: -10)
                            }
                        }
                    }
                }
                
                
                Text("Delicious Food\nFor You")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                
                // SEARCH
                NavigationLink {
                    SearchView(homeVM: vm)
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .foregroundStyle(Color.black)
                }
                
                
                // CATEGORY TABS
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 24) {
                        ForEach(CategoryType.allCases, id: \.self) { category in
                            
                            VStack(spacing: 6) {
                                Button {
                                    withAnimation {
                                        selectedCategory = category
                                    }
                                } label: {
                                    Text(category.rawValue)
                                        .foregroundColor(selectedCategory == category ? .orange : .gray)
                                }
                                
                                if selectedCategory == category {
                                    Rectangle()
                                        .fill(Color.orange)
                                        .frame(height: 3)
                                        .matchedGeometryEffect(id: "underline", in: underlineAnimation)
                                } else {
                                    Rectangle()
                                        .fill(Color.clear)
                                        .frame(height: 3)
                                }
                            }
                        }
                    }
                }
                
                
                NavigationLink("See more") {
                    CategoryListView(items: filtered)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(.orange)
                
                
                // FOOD CARDS
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
                    .padding(.top, 30)
                    .padding(.bottom, 20)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 120)
        }
    }
}
