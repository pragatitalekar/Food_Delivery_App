//
//  MainTabView.swift
//  Food_Delivery_App
//
//  Created by Bhaswanth on 2/6/26.
//

import SwiftUI

struct MainTabView: View {
    @State private var showSideMenu = false
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let homeOffset = width * 0.65
            
            NavigationStack {
                ZStack(alignment: .leading) {
                    Color(.systemBackground).ignoresSafeArea()

                    
                    SideMenuView(showSideMenu: $showSideMenu)
                        .frame(width: width)
                        .offset(x: showSideMenu ? 0 : -width)

                
                    HomeView(showSideMenu: $showSideMenu)
                        .navigationBarBackButtonHidden(true)
                        .frame(width: width)
                        .background(Color.white)
                    
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: showSideMenu ? 40 : 0
                            )
                        )
                        .scaleEffect(showSideMenu ? 0.88 : 1)
                        .offset(
                            x: showSideMenu ? homeOffset + dragOffset : dragOffset
                        )
                        .shadow(
                            color: .black.opacity(showSideMenu ? 0.15 : 0),
                            radius: 20, x: -10, y: 10
                        )
                        .animation(.snappy(duration: 0.4, extraBounce: 0.1), value: showSideMenu)
                        .gesture(sideMenuGesture)
                    
                    if showSideMenu {
                        Color.black.opacity(0.001)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation(.snappy) { showSideMenu = false }
                            }
                            .offset(x: homeOffset)
                    }
                }
            }
        }
    }
    
    var sideMenuGesture: some Gesture {
        DragGesture()
            .updating($dragOffset) { value, state, _ in
                if showSideMenu {
                    if value.translation.width < 0 { state = value.translation.width }
                } else {
                    if value.translation.width > 0 { state = value.translation.width }
                }
            }
            .onEnded { value in
                let threshold: CGFloat = 80
                if showSideMenu {
                    if value.translation.width < -threshold { showSideMenu = false }
                } else {
                    if value.translation.width > threshold { showSideMenu = true }
                }
            }
    }
}
#Preview {
    MainTabView()
}
