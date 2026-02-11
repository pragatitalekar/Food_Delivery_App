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
    @State private var selectedCategory: CategoryType = .meals

    var filtered: [FoodItems] {
        vm.allItems.filter { $0.category == selectedCategory }
    }

    var body: some View {
        NavigationStack {
            TabView {

                homeMainContent
                    .tabItem {
                        Label(Constants.homeString, systemImage: Constants.homeIconString)
                    }

                FavouriteView(allItems: vm.allItems)
                    .tabItem {
                        Label(Constants.likedString, systemImage: Constants.likedIconString)
                    }

                ProfileView()
                    .tabItem {
                        Label(Constants.profileString, systemImage: Constants.profileIconString)
                    }

                OrdersView()
                    .tabItem {
                        Label(Constants.historyString, systemImage: Constants.historyIconString)
                    }
                
            }
           
        }
        .onAppear {
            vm.fetchAll()
        }
    }

    private var homeMainContent: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {

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

                Text("Delicious Food\nFor You")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.textPrimary)

                NavigationLink {
                    SearchView(homeVM: vm)
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color.black)
                        Text("Search")
                        Spacer()
                    }
                    .padding()
                    .background(Color(.white))
                    .cornerRadius(15)
                    
                }

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
                                        .fontWeight(.medium)
                                }

                                ZStack {
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
                }


                NavigationLink("see more") {
                    CategoryListView(items: filtered)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(.orange)

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
                    .padding(.vertical, 50)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .background(Color(.systemGray6))
    }
}

#Preview {
    HomeView(showSideMenu: .constant(false))
        .environmentObject(CartManager())
}

