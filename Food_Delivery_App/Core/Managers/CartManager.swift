import SwiftUI
import Combine

class CartManager: ObservableObject {
   
    @Published var items: [FoodItems] = []
    @Published var favourites: Set<String> = []
    
    init() {
        loadFavourites()
    }
    
    // MARK: CART
    func add(_ item: FoodItems) {
        items.append(item)
        objectWillChange.send()
    }
    
    func remove(_ item: FoodItems) {
        items.removeAll { $0.id == item.id }
        objectWillChange.send()
    }
    
    // INCREMENT
    func increment(_ item: FoodItems) {
        items.append(item)
        objectWillChange.send()
    }
    
    // DECREMENT
    func decrement(_ item: FoodItems) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
            objectWillChange.send()
        }
    }
    
    // QUANTITY COUNT
    func quantity(of item: FoodItems) -> Int {
        items.filter { $0.id == item.id }.count
    }
    
    // TOTAL
    var total: Double {
        items.reduce(0) { $0 + $1.price }
    }
    
    // MARK: FAVOURITES
    func toggleFavourite(_ item: FoodItems) {
        if favourites.contains(item.id) {
            favourites.remove(item.id)
        } else {
            favourites.insert(item.id)
        }
        saveFavourites()
    }
    func removeFavourite(_ item: FoodItems) {
        favourites.remove(item.id)
        saveFavourites()
    }
    func isFavourite(_ item: FoodItems) -> Bool {
        favourites.contains(item.id)
    }
    
    // MARK: PERSISTENCE
    private func saveFavourites() {
        UserDefaults.standard.set(Array(favourites), forKey: "favourites")
    }
    
    private func loadFavourites() {
        if let saved = UserDefaults.standard.array(forKey: "favourites") as? [String] {
            favourites = Set(saved)
        }
    }
}
