//
//  MainTabView.swift
//  Food_Delivery_App
//
//  Created by Bhaswanth on 2/6/26.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var showSideMenu = false
    
    
    var body: some View {
        
        GeometryReader { proxy in
            
            let width = proxy.size.width
            let homeOffset = width * 0.65
            
            NavigationStack {
                
                ZStack(alignment: .leading) {
                    
                    Color(.systemGray6)
                        .ignoresSafeArea()
                    
                    // SIDE MENU
                    SideMenuView(showSideMenu: $showSideMenu)
                        .frame(width: width)
                        .offset(x: showSideMenu ? 0 : -width)
                    
                    // HOME VIEW
                    HomeView(showSideMenu: $showSideMenu)
                        .navigationBarBackButtonHidden(true)
                        .frame(width: width, height: proxy.size.height)
                        .ignoresSafeArea()
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: showSideMenu ? 40 : 0
                            )
                        )
                        .scaleEffect(showSideMenu ? 0.88 : 1)
                        .offset(
                            x: showSideMenu ? homeOffset : 0
                        )
                        
                        .shadow(
                            color: .black.opacity(showSideMenu ? 0.15 : 0),
                            radius: 20,
                            x: -10,
                            y: 10
                        )
                        .animation(
                            .snappy(duration: 0.4, extraBounce: 0.1),
                            value: showSideMenu
                        )
                        
                    
                    if showSideMenu {
                        Color.black.opacity(0.001)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    showSideMenu = false
                                }
                            }
                            .offset(x: homeOffset)
                    }
                }
            }
            .frame(width: width, height: proxy.size.height)
        }
        .ignoresSafeArea()
    }
    
    
}

#Preview {
    MainTabView()
}
