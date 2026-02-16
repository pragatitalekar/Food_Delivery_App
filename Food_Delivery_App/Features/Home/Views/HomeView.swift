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
        
        ZStack {
            
            TabView {
                
                NavigationStack {
                    homeMainContent
                }
                .tabItem {
                    Label("", systemImage: "house")
                }
                
                NavigationStack {
                    FavouriteView(allItems: vm.allItems)
                }
                .tabItem {
                    Label("", systemImage: "heart")
                }
                
                NavigationStack {
                    ProfileView()
                }
                .tabItem {
                    Label("", systemImage: "person")
                }
                
                NavigationStack {
                    OrdersView()
                }
                .tabItem {
                    Label("", systemImage: "bag")
                }
            }
            .tint(.orange)
            .background(Color(.systemGray6).ignoresSafeArea())
           
        }
        
        // INTERNET OVERLAY
        .overlay {
            if vm.showNoInternet {
                NoInternetView {
                    vm.fetchAll()
                }
            }
        }
        
        // SUCCESS POPUP
        .overlay {
            if showSuccessPopup {
                OrderSuccessPopup(show: $showSuccessPopup)
            }
        }
        
        // ACTIVE ORDER STRIP
        .overlay(alignment: .bottom) {
            if !orderManager.activeOrders.isEmpty {
                ActiveOrderCard(order: orderManager.activeOrders.first!)
                    .padding(.bottom, 55)
            }
        }
        
        .onAppear {
            if vm.allItems.isEmpty {
                vm.fetchAll()
            }
        }
    }
    
    // MARK: HOME CONTENT
    private var homeMainContent: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 20) {
                
                // TOP BAR
                HStack {
                    Button {
                        withAnimation(.spring()) {
                            showSideMenu = true
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        CartView()
                    } label: {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "cart")
                                .font(.title2)
                                .foregroundColor(.black)
                            
                            if cart.cartCount > 0 {
                                BadgeView(count: cart.cartCount)
                                    .offset(x: 10, y: -10)
                            }
                        }
                    }
                }
                
                // TITLE
                Text("Delicious \n Food For You")
                    .font(.largeTitle)
                    .bold()
                
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
                    .foregroundColor(.black)
                }
                
                // CATEGORY TABS
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 24) {
                        ForEach(CategoryType.allCases, id: \.self) { category in
                            VStack(spacing: 6) {
                                Button {
                                    withAnimation(.easeInOut(duration: 0.25)) {
                                        selectedCategory = category
                                    }
                                } label: {
                                    Text(category.rawValue)
                                        .foregroundColor(selectedCategory == category ? .orange : .gray)
                                }
                                
                                Rectangle()
                                    .fill(selectedCategory == category ? Color.orange : .clear)
                                    .frame(height: 3)
                                    .matchedGeometryEffect(id: "underline", in: underlineAnimation)
                            }
                        }
                    }
                }
                
                // SEE MORE
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
                    .padding(.vertical, 20)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, orderManager.activeOrders.isEmpty ? 90 : 100)
        }
        .background(Color(.systemGray6))
    }
}
