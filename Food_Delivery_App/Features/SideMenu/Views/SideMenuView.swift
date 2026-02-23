import SwiftUI
import FirebaseAuth

struct SideMenuView: View {

    @Binding var showSideMenu: Bool
    @EnvironmentObject var cart: CartManager
    @EnvironmentObject var orders: OrderManager
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true

    @State private var showingLogoutAlert = false
    @State private var showAuth = false



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
                        title: "Offer and Promo",
                        destination: OffersView(),
                        showSideMenu: $showSideMenu
                    )

                    MenuDivider()

                    MenuRow(
                        icon: "doc.text.fill",
                        title: "Privacy Policy",
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

                // ⭐ SIGN IN / OUT BUTTON
                Button {
                    if isLoggedIn {
                        showingLogoutAlert = true
                    } else {
                        showSideMenu = false
                        showAuth = true
                    }
                } label: {
                    HStack(spacing: 12) {

                        Text(isLoggedIn ? "Sign Out" : "Sign In")
                            .font(.system(size: 18, weight: .medium))

                        Image(systemName: isLoggedIn ? "arrow.right" : "person.fill")
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
        .sheet(isPresented: $showAuth) {
            AuthView {
                showAuth = false
                isLoggedIn = true
                orders.restoreSession()
            }
        }
    }

    private func handleSignOut() {
        do {
            try Auth.auth().signOut()
            orders.clearSession()
            cart.clearCart{}
            isLoggedIn = false
            showSideMenu = false
        } catch {
            print("Sign out error:", error.localizedDescription)
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
        SideMenuView(showSideMenu: .constant(false))
    }
}


