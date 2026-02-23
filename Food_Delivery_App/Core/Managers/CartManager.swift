import SwiftUI
import Combine

final class CartManager: ObservableObject {

    // MARK: - Cart State (Firebase)
    @Published var items: [String: (item: FoodItems, qty: Int)] = [:]
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Favourites (Firebase)
    @Published var favouriteItems: [FavouriteItem] = []

    // Derived favourite IDs (single source of truth)
    var favourites: Set<String> {
        Set(favouriteItems.map { $0.id })
    }

    private let cartService = CartService.shared
    private let favouriteService = FavouriteService.shared

    // MARK: - INIT
    init() {}

    // MARK: - LOAD CART
    func loadCart() {
        isLoading = true
        errorMessage = nil

        cartService.fetchCartItems { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false

                switch result {
                case .success(let data):
                    self?.items = Dictionary(
                        uniqueKeysWithValues: data.map {
                            ($0.0.id, (item: $0.0, qty: $0.1))
                        }
                    )

                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: - ADD / INCREMENT
    func add(_ item: FoodItems) {
        increment(item)
    }

    func increment(_ item: FoodItems) {
        cartService.addToCart(item: item) { [weak self] result in
            DispatchQueue.main.async {
                if case .failure(let error) = result {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.loadCart()
                }
            }
        }
    }

    // MARK: - DECREMENT (minus button)
    func decrement(_ item: FoodItems) {
        cartService.decrementItem(itemId: item.id) { [weak self] result in
            DispatchQueue.main.async {
                if case .failure(let error) = result {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.loadCart()
                }
            }
        }
    }

    // MARK: - REMOVE (🗑 DELETE — HARD DELETE)
    func remove(_ item: FoodItems) {
        cartService.deleteItem(itemId: item.id) { [weak self] result in
            DispatchQueue.main.async {
                if case .failure(let error) = result {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.loadCart()
                }
            }
        }
    }

    // MARK: - QUANTITY
    func quantity(of item: FoodItems) -> Int {
        items[item.id]?.qty ?? 0
    }

    // MARK: - CART COUNT
    var cartCount: Int {
        items.values.reduce(0) { $0 + $1.qty }
    }
    
  

    // MARK: - TOTAL PRICE
    var total: Double {
        items.values.reduce(0) {
            $0 + ($1.item.price * Double($1.qty))
        }
    }

    // MARK: - FAVOURITES (Firebase)

    func loadFavourites() {
        favouriteService.fetchFavouriteItems { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self?.favouriteItems = items
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func toggleFavourite(_ item: FoodItems) {
        if favourites.contains(item.id) {
            removeFavourite(item)
        } else {
            addFavourite(item)
        }
    }

    func isFavourite(_ item: FoodItems) -> Bool {
        favourites.contains(item.id)
    }

    func removeFavourite(_ item: FoodItems) {
        favouriteService.removeFavourite(itemId: item.id) { [weak self] _ in
            self?.loadFavourites()
        }
    }

    // MARK: - ADD FAVOURITE (validated)
    private func addFavourite(_ item: FoodItems) {
        guard
            !item.image.isEmpty,
            let url = URL(string: item.image),
            url.scheme == "https"
        else {
            print("❌ Invalid image URL for favourite:", item.image)
            return
        }

        favouriteService.addFavourite(item: item) { [weak self] _ in
            self?.loadFavourites()
        }
    }
    // MARK: - CLEAR ENTIRE CART (after order success)
    func clearCart(completion: (() -> Void)? = nil) {

        // ⭐ CLEAR LOCAL STATE FIRST (instant UI update)
        items.removeAll()

        cartService.clearCart { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    completion?()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
