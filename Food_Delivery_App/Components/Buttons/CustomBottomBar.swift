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
            tabButton(icon: "house", tab: .home)
            Spacer()
            tabButton(icon: "heart", tab: .favourites)
            Spacer()
            tabButton(icon: "person", tab: .profile)
            Spacer()
            tabButton(icon: "clock", tab: .orders)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 14)
        .background(Color(.systemGray6))
    }

    func tabButton(icon: String, tab: TabType) -> some View {
        Button {
            selectedTab = tab
        } label: {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(selectedTab == tab ? .orange : .gray)
        }
    }
}

