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
            tab(icon: "house.fill", tab: .home)
            Spacer()
            tab(icon: "heart.fill", tab: .favourites)
            Spacer()
            tab(icon: "person.fill", tab: .profile)
            Spacer()
            tab(icon: "clock.fill", tab: .orders)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 14)
        .background(Color(.systemGray6))
        .cornerRadius(28)
        .shadow(color: .black.opacity(0.08), radius: 10, y: 5)
        .padding(.horizontal, 24)
        .padding(.bottom, 10)
    }

    func tab(icon: String, tab: TabType) -> some View {
        Button {
            selectedTab = tab
        } label: {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(selectedTab == tab ? .orange : .gray)
        }
    }
}
