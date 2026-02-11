//
//  DashboardView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/8/26.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject var cart: CartManager
    @State private var showSideMenu: Bool = false
    @StateObject private var homeVM = HomeViewModel()

    var body: some View {
        NavigationStack {
            
            TabView {
                
                Tab(Constants.homeString, systemImage: Constants.homeIconString) {
                    
                        HomeView(showSideMenu: $showSideMenu)
                   
                }
                
               
                Tab(Constants.likedString, systemImage: Constants.likedIconString) {
                    FavouriteView(allItems: homeVM.allItems)
                }
                
            
                Tab(Constants.profileString, systemImage: Constants.profileIconString) {
                    Text("Profile")
                }
                
              
                Tab(Constants.historyString, systemImage: Constants.historyIconString) {
                    Text("Order History")
                }
            }
        }
        .onAppear {
            homeVM.fetchAll()
        }
    }
}

#Preview {
    DashboardView()
}
