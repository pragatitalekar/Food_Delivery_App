import SwiftUI
import Combine

class CartManager: ObservableObject {
    
    @Published var items: [CartItem] = []
    @Published var favourites: Set<String> = []
    
    private let persistence = PersistenceService.shared
    
    init() {
        favourites = persistence.loadFavourites()
    }
    
    // ADD / INCREMENT
    func increment(_ food: FoodItems) {
        if let index = items.firstIndex(where: { $0.id == food.id }) {
            items[index].qty += 1
        } else {
            let newItem = CartItem(id: food.id, item: food, qty: 1)
            items.append(newItem)
        }
    }
    
    // DECREMENT
    func decrement(_ food: FoodItems) {
        guard let index = items.firstIndex(where: { $0.id == food.id }) else { return }
        
        if items[index].qty > 1 {
            items[index].qty -= 1
        } else {
            items.remove(at: index)
        }
    }
    
    // REMOVE
    func remove(_ food: FoodItems) {
        items.removeAll { $0.id == food.id }
    }
    
    // QUANTITY
    func quantity(of food: FoodItems) -> Int {
        items.first(where: { $0.id == food.id })?.qty ?? 0
    }
    
    // TOTAL
    var total: Double {
        items.reduce(0) { $0 + ($1.item.price * Double($1.qty)) }
    }
    
    // COUNT
    var cartCount: Int {
        items.reduce(0) { $0 + $1.qty }
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
    
    func isFavourite(_ item: FoodItems) -> Bool {
        favourites.contains(item.id)
    }
    func removeFavourite(_ item: FoodItems) {
    favourites.remove(item.id)
    persistence.saveFavourites(favourites)
    }
}
