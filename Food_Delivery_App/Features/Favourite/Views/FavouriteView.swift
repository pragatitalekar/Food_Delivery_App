import SwiftUI

struct FavouriteView: View {

    @EnvironmentObject var cart: CartManager
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    @State private var showAuth = false
    @State private var animate = false

    var body: some View {

        ZStack {
         
           
            
            Color(.systemGray6)
                .ignoresSafeArea()

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

               
                else if cart.favouriteItems.isEmpty {

                    VStack(spacing: 20) {

                        Spacer()

                        Image(systemName: "heart")
                            .font(.system(size: 80))
                            .foregroundColor(.orange)
                            .scaleEffect(animate ? 1.15 : 0.9)
                            .animation(
                                Animation.easeInOut(duration: 1)
                                    .repeatForever(autoreverses: true),
                                value: animate
                            )
                            .onAppear {
                                animate = true
                            }

                        Text("No favourites added")
                            .font(.title3)
                            .fontWeight(.bold)

                        Text("Tap the heart icon on food\nto save it here")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)

                        Spacer()
                    }
                }

                
                else {
                    favouritesGrid
                }
            }
        }
       
    }
        
}

private extension FavouriteView {

    var favouritesGrid: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 15),
                    GridItem(.flexible(), spacing: 15)
                ],
                spacing: 20
            ) {
                ForEach(cart.favouriteItems) { fav in
                    VStack(spacing: 8) {

                        NavigationLink {
                            DetailView(item: fav.foodItem)
                        } label: {
                            ItemCard(item: fav.foodItem)
                                .frame(height: 250)
                        }
                        .buttonStyle(.plain)

                        Button("Remove") {
                            cart.removeFavourite(fav.foodItem)
                        }
                        .foregroundColor(.red)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 100)
        }
    }
}
