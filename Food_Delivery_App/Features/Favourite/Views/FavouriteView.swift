import SwiftUI

struct FavouriteView: View {

    @EnvironmentObject var cart: CartManager
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    @State private var showAuth = false

    var body: some View {

        Group {

          
            if !isLoggedIn {

                VStack(spacing: 24) {

                    Spacer()

                    Image(systemName: "heart.slash")
                        .font(.system(size: 70))
                        .foregroundColor(.gray.opacity(0.6))

                    Text("No favourites yet")
                        .font(.title3)
                        .fontWeight(.semibold)

                    Text("Login to save your favourite food")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Button {
                        showAuth = true
                    } label: {
                        Text("Login / Sign-up")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppColors.primary)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                    }
                    .padding(.horizontal, 30)

                    Spacer()
                }
                .sheet(isPresented: $showAuth) {
                    AuthView {
                        showAuth = false
                        isLoggedIn = true
                    }
                }
            }

            // ✅ LOGGED IN UI (your original grid)
            else {
                favouritesGrid
            }
        }
        .navigationTitle("Favourites")
        .background(Color(.systemGray6))
    }
}

private extension FavouriteView {

    var favouritesGrid: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 40),
                    GridItem(.flexible(), spacing: 40)
                ],
                spacing: 40
            ) {
                ForEach(cart.favouriteItems) { fav in
                    VStack(spacing: 8) {

                        NavigationLink {
                            DetailView(item: fav.foodItem)
                        } label: {
                            ItemCard(item: fav.foodItem)
                                .frame(width: 165, height: 250)
                        }
                        .buttonStyle(.plain)

                        Button("Remove") {
                            cart.removeFavourite(fav.foodItem)
                        }
                        .foregroundColor(.red)
                    }
                }
            }
            .padding()
        }
    }
}
