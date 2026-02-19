import FirebaseFirestore
import FirebaseAuth

final class FavouriteService {

    static let shared = FavouriteService()

    private let db = Firestore.firestore()
    private init() {}

    private var uid: String? {
        Auth.auth().currentUser?.uid
    }

    // MARK: - Fetch Favourites
    func fetchFavouriteItems(
        completion: @escaping (Result<[FavouriteItem], Error>) -> Void
    ) {
        guard let uid else {
            completion(.success([]))
            return
        }

        db.collection("users")
            .document(uid)
            .collection("favourites")
            .order(by: "addedAt", descending: true)
            .getDocuments { snapshot, error in

                if let error {
                    completion(.failure(error))
                    return
                }

                let items = snapshot?.documents.compactMap { doc -> FavouriteItem? in
                    let data = doc.data()

                    guard
                        let name = data["name"] as? String,
                        let image = data["image"] as? String,
                        let price = data["price"] as? Double,
                        let categoryRaw = data["category"] as? String,
                        let category = CategoryType(rawValue: categoryRaw)
                    else {
                        return nil
                    }

                    let food = FoodItems(
                        id: doc.documentID,
                        name: name,
                        image: image,
                        price: price,
                        category: category
                    )

                    return FavouriteItem(
                        id: doc.documentID,
                        foodItem: food,
                        imageURL: image
                    )
                } ?? []

                completion(.success(items))
            }
    }

    // MARK: - Add Favourite
    func addFavourite(
        item: FoodItems,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {

        guard let uid else { return }

        db.collection("users")
            .document(uid)
            .collection("favourites")
            .document(item.id)
            .setData([
                "name": item.name,
                "image": item.image,
                "price": item.price,
                "category": item.category.rawValue,
                "addedAt": Timestamp(date: Date())
            ]) { error in
                error == nil
                    ? completion(.success(()))
                    : completion(.failure(error!))
            }
    }

    // MARK: - Remove Favourite
    func removeFavourite(
        itemId: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {

        guard let uid else { return }

        db.collection("users")
            .document(uid)
            .collection("favourites")
            .document(itemId)
            .delete { error in
                error == nil
                    ? completion(.success(()))
                    : completion(.failure(error!))
            }
    }
}
