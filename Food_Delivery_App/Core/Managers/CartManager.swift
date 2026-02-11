import SwiftUI
import Combine

class CartManager: ObservableObject {

    @Published var items: [FoodItems] = []
    @Published var favourites: Set<String> = []

    private let persistence = PersistenceService.shared

    init() {
        favourites = persistence.loadFavourites()
    }

    
    func add(_ item: FoodItems) {
        items.append(item)
    }

    func remove(_ item: FoodItems) {
        items.removeAll { $0.id == item.id }
    }

    func increment(_ item: FoodItems) {
        items.append(item)
    }

    func decrement(_ item: FoodItems) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }

    func quantity(of item: FoodItems) -> Int {
        items.filter { $0.id == item.id }.count
    }

    var total: Double {
        items.reduce(0) { $0 + $1.price }
    }

    
    func toggleFavourite(_ item: FoodItems) {
        if favourites.contains(item.id) {
            favourites.remove(item.id)
        } else {
            favourites.insert(item.id)
        }
        persistence.saveFavourites(favourites)
    }

    func removeFavourite(_ item: FoodItems) {
        favourites.remove(item.id)
        persistence.saveFavourites(favourites)
    }

    func isFavourite(_ item: FoodItems) -> Bool {
        favourites.contains(item.id)
    }
}
