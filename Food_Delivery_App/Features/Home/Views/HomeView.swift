import SwiftUI

struct HomeView: View {
    
    @Binding var showSideMenu: Bool
    @Namespace private var underlineAnimation
    @StateObject private var vm = HomeViewModel()
    
    @EnvironmentObject var cart: CartManager
    @EnvironmentObject var orderManager: OrderManager
    
    @State private var selectedCategory: CategoryType = .meals
    @State private var showSuccessPopup = false
    
    var body: some View {
        
<<<<<<< HEAD
        ZStack {
=======
        TabView {
            NavigationStack {
                homeMainContent
            }
            .tabItem {
                Image(systemName: Constants.homeIconString)
            }
            NavigationStack {
                FavouriteView()
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
            
>>>>>>> 6512372 (added firebase for both cart and favourite)
            
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
        
        .overlay {
            if vm.showNoInternet {
                NoInternetView {
                    vm.fetchAll()
                }
            }
        }
        
        .overlay {
            if showSuccessPopup {
                OrderSuccessPopup(show: $showSuccessPopup)
            }
        }
        
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
        
        ScrollViewReader { proxy in
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    // HEADER
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
                    Text("Delicious\nFood For You")
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
                    
                    // CATEGORY BAR
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 24) {
                            ForEach(CategoryType.allCases, id: \.self) { category in
                                VStack(spacing: 6) {
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.25)) {
                                            selectedCategory = category
                                            proxy.scrollTo(category, anchor: .top)
                                        }
                                    } label: {
                                        Text(category.rawValue)
                                            .foregroundColor(selectedCategory == category ? .orange : .gray)
                                    }
                                    
                                    Rectangle()
                                        .fill(Color.orange)
                                        .frame(height: 3)
                                        .opacity(selectedCategory == category ? 1 : 0)
                                        .matchedGeometryEffect(id: "underline", in: underlineAnimation)
                                }
                            }
                        }
                    }
                    
                    // SECTIONS
                    categorySection(title: "Meals", category: .meals)
                        .id(CategoryType.meals)
                    
                    categorySection(title: "Drinks", category: .drinks)
                        .id(CategoryType.drinks)
                    
                    categorySection(title: "Snacks", category: .snacks)
                        .id(CategoryType.snacks)
                    
                    categorySection(title: "Desserts", category: .desserts)
                        .id(CategoryType.desserts)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, orderManager.activeOrders.isEmpty ? 90 : 100)
                
                // AUTO UNDERLINE MOVE
                .onPreferenceChange(CategoryOffsetKey.self) { values in
                    
                    let sorted = values.sorted { abs($0.value) < abs($1.value) }
                    
                    if let nearest = sorted.first?.key {
                        if selectedCategory != nearest {
                            selectedCategory = nearest
                        }
                    }
                }
            }
        }
        .background(Color(.systemGray6))
    }
    
    // MARK: CATEGORY SECTION
    
    private func categorySection(title: String, category: CategoryType) -> some View {
        
        let items = vm.allItems.filter { $0.category == category }
        
        return VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                Text(title)
                    .font(.title3)
                    .bold()
                
                Spacer()
                
                NavigationLink("See more") {
                    CategoryListView(items: items)
                }
                .foregroundColor(.orange)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(items.prefix(6)) { item in
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
        .background(
            GeometryReader { geo in
                Color.clear.preference(
                    key: CategoryOffsetKey.self,
                    value: [category: geo.frame(in: .global).minY]
                )
            }
        )
    }
}
struct CategoryOffsetKey: PreferenceKey {
    static var defaultValue: [CategoryType: CGFloat] = [:]
    
    static func reduce(value: inout [CategoryType: CGFloat], nextValue: () -> [CategoryType: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}
