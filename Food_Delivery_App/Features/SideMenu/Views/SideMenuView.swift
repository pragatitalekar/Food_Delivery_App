//
//  SideMenuView.swift
//  Food_Delivery_App
//
//  Created by Bhaswanth on 2/6/26.
//
import SwiftUI

struct SideMenuView: View {
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            AppColors.primary
                .ignoresSafeArea()
            

            VStack(alignment: .leading, spacing: 28) {
                
                Spacer().frame(height: 80)
                
                
                MenuRow(
                    icon: "person.crop.circle.fill",
                    title: "Profile",
                    option: .profile
                )
                MenuDivider()
                MenuRow(
                    icon: "bag.fill",
                    title: "Orders",
                    option: .orders
                )
                MenuDivider()
                MenuRow(
                    icon: "percent",
                    title: "Offer and promo",
                    option: .offers
                )
                MenuDivider()
                MenuRow(
                    icon: "doc.text.fill",
                    title: "Privacy policy",
                    option: .privacy
                )
                MenuDivider()
                MenuRow(
                    icon: "lock.fill",
                    title: "Security",
                    option: .security
                )


                
                
                Spacer()
                
                
                HStack(spacing: 8) {
                    Text("Sign-out")
                        .foregroundColor(AppColors.white)
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    Image(systemName: "arrow.right")
                        .foregroundColor(AppColors.white)
                        .font(.title2)
                }
                .padding(.bottom, 40)
                
            }
            .padding(.leading, 30)
            .frame(width: 280)
            
        }
        
    }
}


struct MenuRow: View {
    
    var icon: String
    var title: String
    var option: SideMenuOption
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        Button {
            navigationManager.path.append(option)
        } label: {
            HStack(spacing: 18) {
                Image(systemName: icon)
                Text(title)
            }
            .foregroundColor(AppColors.white)
            .font(.title3)
            .fontWeight(.medium)
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
    }
}


struct MenuDivider: View {
    
    var body: some View {
        
        Rectangle()
            .fill(AppColors.white.opacity(0.6))
            .frame(height: 1)
            .padding(.leading, 38)
            .padding(.trailing, 40)
        
    }
}

#Preview(){
    SideMenuView()
}
