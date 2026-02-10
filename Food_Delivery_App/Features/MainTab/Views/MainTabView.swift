//
//  MainTabView.swift
//  Food_Delivery_App
//
//  Created by Bhaswanth on 2/6/26.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var navigationManager = NavigationManager.shared
    
    private let menuOffsetClosed: CGFloat = -400
    private let homeOffsetOpen: CGFloat = 260
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            SideMenuView()
                .environmentObject(navigationManager)
                .offset(x: navigationManager.showSideMenu ? 0 : menuOffsetClosed)
                .animation(
                    .spring(response: 0.45, dampingFraction: 0.82, blendDuration: 0.25),
                    value: navigationManager.showSideMenu
                )
            
            ZStack {
                AppColors.background
                        .ignoresSafeArea()

                NavigationStack(path: $navigationManager.path) {
                    DashboardView()
                        .environmentObject(navigationManager)
                        .navigationDestination(for: SideMenuOption.self) { option in
                            switch option {
                            case .profile:
                                ProfileView()
                                    .environmentObject(navigationManager)
                            case .orders:
                                OrdersView()
                                    .environmentObject(navigationManager)
                            case .offers:
                                OffersView()
                                    .environmentObject(navigationManager)
                            case .privacy:
                                PrivacyView()
                                    .environmentObject(navigationManager)
                            case .security:
                                SecurityView()
                                    .environmentObject(navigationManager)
                            }
                        }
                }
            }
            .cornerRadius(navigationManager.showSideMenu ? 40 : 0)
            .scaleEffect(navigationManager.showSideMenu ? 0.9 : 1.0)
            .offset(x: navigationManager.showSideMenu ? homeOffsetOpen : 0)
            .shadow(
                color: navigationManager.showSideMenu ? AppColors.shadow.opacity(0.3) : .clear,
                radius: navigationManager.showSideMenu ? 20 : 0,
                x: navigationManager.showSideMenu ? -15 : 0,
                y: navigationManager.showSideMenu ? 15 : 0
            )
            
            .shadow(
                color: navigationManager.showSideMenu ? AppColors.shadow.opacity(0.15) : .clear,
                radius: navigationManager.showSideMenu ? 50 : 0,
                x: navigationManager.showSideMenu ? -25 : 0,
                y: navigationManager.showSideMenu ? 25 : 0
            )
            .animation(.spring(response: 0.45, dampingFraction: 0.82, blendDuration: 0.25), value: navigationManager.showSideMenu)
            .onTapGesture {
                if navigationManager.showSideMenu {
                    navigationManager.showSideMenu = false
                }
            }
            .onChange(of: navigationManager.path.count) { oldValue, newValue in
                withAnimation(.spring(response: 0.45, dampingFraction: 0.82, blendDuration: 0.25)) {
                    navigationManager.showSideMenu = (newValue == 0)
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}

