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
<<<<<<< HEAD
                                  DetailView(item: item)
                              } label: {
                                  ItemCard(item: item)
                                      .frame(width: 165, height: 250)
                              }
                              .buttonStyle(.plain)
=======
                            DetailView(item: fav.foodItem)
                        } label: {
                            ItemCard(item: fav.foodItem)
                        }
                        .buttonStyle(.plain)
>>>>>>> 6512372 (added firebase for both cart and favourite)

                        Button("Remove") {
                            cart.removeFavourite(fav.foodItem)
                        }
                        .foregroundColor(.red)
                    }
                }
            }
            .padding()
<<<<<<< HEAD
          

=======
>>>>>>> 6512372 (added firebase for both cart and favourite)
        }
        .navigationTitle("Favourites")
        .background(Color(.systemGray6))
    }
<<<<<<< HEAD
      

   
    var favouriteItems: [FoodItems] {
        allItems.filter { cart.isFavourite($0) }
    }
=======
>>>>>>> 6512372 (added firebase for both cart and favourite)
}
