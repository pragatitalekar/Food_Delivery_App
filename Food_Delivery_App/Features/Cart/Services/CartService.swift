import FirebaseFirestore
import FirebaseAuth

final class CartService {

    static let shared = CartService()

    private let db = Firestore.firestore()

    private init() {}

    private var uid: String? {
        Auth.auth().currentUser?.uid
    }

    //Fetch Cart Items
    func fetchCartItems(
        completion: @escaping (Result<[(FoodItems, Int)], Error>) -> Void
    ) {

        guard let uid else {
            completion(.success([]))
            return
        }

        db.collection("users")
            .document(uid)
            .collection("cart")
            .order(by: "addedAt", descending: true)
            .getDocuments { snapshot, error in

                if let error {
                    completion(.failure(error))
                    return
                }

                let items = snapshot?.documents.compactMap { doc -> (FoodItems, Int)? in
                    let data = doc.data()

                    guard
                        let name = data["name"] as? String,
                        let image = data["image"] as? String,
                        let price = data["price"] as? Double,
                        let categoryRaw = data["category"] as? String,
                        let category = CategoryType(rawValue: categoryRaw),
                        let quantity = data["quantity"] as? Int
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

                    return (food, quantity)
                } ?? []

                completion(.success(items))
            }
    }

    //Add or Increment Item
    func addToCart(
        item: FoodItems,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {

        guard let uid else { return }

        let ref = db.collection("users")
            .document(uid)
            .collection("cart")
            .document(item.id)

        ref.getDocument { snapshot, error in

            if let error {
                completion(.failure(error))
                return
            }

            if let snapshot, snapshot.exists {
                // Quantity already exists → increment
                ref.updateData([
                    "quantity": FieldValue.increment(Int64(1))
                ]) { error in
                    error == nil
                        ? completion(.success(()))
                        : completion(.failure(error!))
                }
            } else {
                // First time add
                ref.setData([
                    "name": item.name,
                    "image": item.image,
                    "price": item.price,
                    "category": item.category.rawValue,
                    "quantity": 1,
                    "addedAt": Timestamp(date: Date())
                ]) { error in
                    error == nil
                        ? completion(.success(()))
                        : completion(.failure(error!))
                }
            }
        }
    }

    // MARK: - Decrement Quantity
    func decrementItem(
        itemId: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {

        guard let uid else { return }

        let ref = db.collection("users")
            .document(uid)
            .collection("cart")
            .document(itemId)

        ref.getDocument { snapshot, error in

            if let error {
                completion(.failure(error))
                return
            }

            guard
                let data = snapshot?.data(),
                let quantity = data["quantity"] as? Int
            else { return }

            if quantity > 1 {
                ref.updateData([
                    "quantity": FieldValue.increment(Int64(-1))
                ]) { error in
                    error == nil
                        ? completion(.success(()))
                        : completion(.failure(error!))
                }
            } else {
                ref.delete { error in
                    error == nil
                        ? completion(.success(()))
                        : completion(.failure(error!))
                }
            }
        }
    }
    
    func deleteItem(
        itemId: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        guard let uid else { return }

        db.collection("users")
            .document(uid)
            .collection("cart")
            .document(itemId)
            .delete { error in
                error == nil
                    ? completion(.success(()))
                    : completion(.failure(error!))
            }
    }

}
