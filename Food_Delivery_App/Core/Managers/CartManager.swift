import SwiftUI
import Combine

class CartManager: ObservableObject {

    @Published var items: [String: (item: FoodItems, qty: Int)] = [:]
    @Published var favourites: Set<String> = []

    private let persistence = PersistenceService.shared

    init() {
        favourites = persistence.loadFavourites()
    }

    // ADD
    func add(_ item: FoodItems) {
        var newItems = items
        if let existing = newItems[item.id] {
            newItems[item.id] = (item, existing.qty + 1)
        } else {
            newItems[item.id] = (item, 1)
        }
        items = newItems   // 🔥 important
    }

    // INCREMENT
    func increment(_ item: FoodItems) {
        add(item)
    }

    // DECREMENT
    func decrement(_ item: FoodItems) {
        var newItems = items
        guard let existing = newItems[item.id] else { return }

        if existing.qty > 1 {
            newItems[item.id] = (item, existing.qty - 1)
        } else {
            newItems.removeValue(forKey: item.id)
        }

        items = newItems   // 🔥 important
    }

    // REMOVE
    func remove(_ item: FoodItems) {
        var newItems = items
        newItems.removeValue(forKey: item.id)
        items = newItems
    }

    // QUANTITY
    func quantity(of item: FoodItems) -> Int {
        items[item.id]?.qty ?? 0
    }

    // TOTAL
    var total: Double {
        items.values.reduce(0) { $0 + ($1.item.price * Double($1.qty)) }
    }

    // FAVOURITES
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
