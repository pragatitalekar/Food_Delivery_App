import SwiftUI

struct HomeView: View {
    
    @Binding var showSideMenu: Bool
    @Namespace private var underlineAnimation
    @StateObject private var vm = HomeViewModel()
    
    @EnvironmentObject var cart: CartManager
    @EnvironmentObject var orderManager: OrderManager
    
    @State private var selectedCategory: CategoryType = .meals
    @State private var selectedTab: TabType = .home
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            TabView(selection: $selectedTab) {
                
                NavigationStack {
                    homeMainContent
                }
                .tag(TabType.home)
                
                NavigationStack {
                    FavouriteView(allItems: vm.allItems)
                }
                .tag(TabType.favourites)
                
                NavigationStack {
                    ProfileView()
                }
                .tag(TabType.profile)
                
                NavigationStack {
                    OrdersView()
                }
                .tag(TabType.orders)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .background(Color(.systemGray6).ignoresSafeArea())
            
            CustomBottomBar(selectedTab: $selectedTab)
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
                
                VStack(alignment: .leading, spacing: 18) {
                    
                    // HEADER
                    HStack {
                        Button {
                            withAnimation(.spring()) { showSideMenu = true }
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
                                    Text("\(cart.cartCount)")
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .background(Color.orange)
                                        .clipShape(Circle())
                                        .offset(x: 8, y: -8)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 6)
                    
                    // TITLE
                    Text("Delicious\nfood for you")
                        .font(.system(size: 34, weight: .bold))
                        .lineSpacing(3)
                        .padding(.top, 6)
                    
                    // SEARCH
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
                    .padding(.top, 4)
                    
                    // CATEGORY BAR
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 22) {
                            ForEach(CategoryType.allCases, id: \.self) { category in
                                VStack(spacing: 6) {
                                    Button {
                                        withAnimation(.easeInOut) {
                                            selectedCategory = category
                                            proxy.scrollTo(category, anchor: .top)
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
                                      //  .matchedGeometryEffect(id: "underline", in: underlineAnimation)
                                }
                            }
                        }
                        .padding(.top, 6)
                    }
                    
                    // SECTIONS
                    categorySection(title: "Foods", category: .meals)
                        .id(CategoryType.meals)
                    
                    categorySection(title: "Drinks", category: .drinks)
                        .id(CategoryType.drinks)
                    
                    categorySection(title: "Snacks", category: .snacks)
                        .id(CategoryType.snacks)
                    
                    categorySection(title: "Desserts", category: .desserts)
                        .id(CategoryType.desserts)
                }
                .padding(.horizontal, 28)
                .padding(.top, 18)
                .padding(.bottom, 150)
            }
        }
        .background(Color(.systemGray6))
    }
    
    // MARK: CATEGORY SECTION
    
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
    }
}
