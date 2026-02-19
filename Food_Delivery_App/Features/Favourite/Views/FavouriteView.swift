import SwiftUI

struct FavouriteView: View {

    @EnvironmentObject var cart: CartManager

    var body: some View {
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
        .navigationTitle("Favourites")
        .background(Color(.systemGray6))
    }

}
