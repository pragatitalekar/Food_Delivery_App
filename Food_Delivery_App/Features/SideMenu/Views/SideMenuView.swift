//
//  SideMenuView.swift
//  Food_Delivery_App
//

import SwiftUI
import FirebaseAuth

struct SideMenuView: View {
    
    @Binding var showSideMenu: Bool
 
    
    @State private var showingLogoutAlert = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            AppColors.primary
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                
                Spacer().frame(height: 100)
                
                Group {
                    
                    MenuRow(
                        icon: "person.crop.circle.fill",
                        title: "Profile",
                        destination: ProfileView(),
                        showSideMenu: $showSideMenu
                    )
                    
                    MenuDivider()
                    
                    MenuRow(
                        icon: "clock.arrow.circlepath",
                        title: "Order History",
                        destination: HistoryView(),
                        showSideMenu: $showSideMenu
                    )
                    
                    MenuDivider()
                    
                    MenuRow(
                        icon: "percent",
                        title: "offer and promo",
                        destination: OffersView(),
                        showSideMenu: $showSideMenu
                    )
                    
                    MenuDivider()
                    
                    MenuRow(
                        icon: "doc.text.fill",
                        title: "Privacy policy",
                        destination: PrivacyView(),
                        showSideMenu: $showSideMenu
                    )
                    
                    MenuDivider()
                    
                    MenuRow(
                        icon: "lock.fill",
                        title: "Security",
                        destination: SecurityView(),
                        showSideMenu: $showSideMenu
                    )
                }
                
                Spacer()
                
                Button {
                    showingLogoutAlert = true
                } label: {
                    HStack(spacing: 12) {
                        Text("Sign-out")
                            .font(.system(size: 18, weight: .medium))
                        
                        Image(systemName: "arrow.right")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .foregroundColor(AppColors.white)
                }
                .padding(.bottom, 50)
                .alert("Sign Out", isPresented: $showingLogoutAlert) {
                    
                    Button("Cancel", role: .cancel) { }
                    
                    Button("Sign Out", role: .destructive) {
                        handleSignOut()
                    }
                    
                } message: {
                    Text("Are you sure you want to sign out of your account?")
                }
            }
            .padding(.leading, 35)
        }
    }
    
    private func handleSignOut() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch {
            print(error.localizedDescription)
        }
    }
}



struct MenuRow<Destination: View>: View {
    
    var icon: String
    var title: String
    var destination: Destination
    @Binding var showSideMenu: Bool
    
    var body: some View {
        
        NavigationLink {
            destination
                .onAppear {
                    showSideMenu = false
                }
        } label: {
            HStack(spacing: 16) {
                
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .frame(width: 24)
                
                Text(title)
                    .font(.system(size: 18, weight: .medium))
            }
            .foregroundColor(AppColors.white)
            .padding(.vertical, 20)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}


struct MenuDivider: View {
    var body: some View {
        Rectangle()
            .fill(AppColors.white.opacity(0.3))
            .frame(height: 1)
            .frame(width: 130)
            .padding(.leading, 38)
    }
}



#Preview {
    NavigationStack {
        SideMenuView(
            showSideMenu: .constant(false),
           
        )
    }
}
