//
//  CustomBottomBar.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/11/26.
//


import SwiftUI

struct CustomBottomBar: View {

    @Binding var selectedTab: TabType

    var body: some View {
        HStack {
            tab(icon: "house", tab: .home)
            Spacer()
            tab(icon: "heart", tab: .favourites)
            Spacer()
            tab(icon: "person", tab: .profile)
            Spacer()
            tab(icon: "clock", tab: .orders)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 14)
        .background(Color(.systemGray6).opacity(0.85))
        .cornerRadius(28)
        .shadow(color: Color(.systemGray6).opacity(0.04), radius: 10, y: 5)
        .padding(.horizontal, 24)
        .padding(.bottom, 20)
    }

    func tab(icon: String, tab: TabType) -> some View {
        Button {
            selectedTab = tab
        } label: {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(selectedTab == tab ? AppColors.primary : Color(.systemGray))
                
                
        }
    }
}
