//
//  AddressService.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/12/26.
//


import FirebaseFirestore
import FirebaseAuth

final class AddressService {

    static let shared = AddressService()

    private let db = Firestore.firestore()

    private init() {}

    private var uid: String? {
        Auth.auth().currentUser?.uid
    }


    func fetchAddresses(
        completion: @escaping (Result<[UserAddress], Error>) -> Void
    ) {

        guard let uid else { return }

        db.collection("users")
            .document(uid)
            .collection("addresses")
            .order(by: "createdAt", descending: true)
            .getDocuments { snapshot, error in

                if let error {
                    completion(.failure(error))
                    return
                }

                let addresses = snapshot?.documents.compactMap { doc -> UserAddress? in

                    let data = doc.data()

                    return UserAddress(
                        id: doc.documentID,
                        name: data["name"] as? String ?? "",
                        fullName: data["fullName"] as? String ?? "",
                        phone: data["phone"] as? String ?? "",
                        street: data["street"] as? String ?? "",
                        isDefault: data["isDefault"] as? Bool ?? false,
                        createdAt: (data["createdAt"] as? Timestamp)?.dateValue() ?? Date()
                    )

                } ?? []

                completion(.success(addresses))
            }
    }


    func addAddress(
        _ address: UserAddress,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {

        guard let uid else { return }

        let ref = db.collection("users")
            .document(uid)
            .collection("addresses")
            .document()

        ref.setData([
            "name": address.name,
            "fullName": address.fullName,
            "phone": address.phone,
            "street": address.street,
            "isDefault": address.isDefault,
            "createdAt": Timestamp(date: address.createdAt)
        ]) { error in

            if let error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }


    func deleteAddress(
        id: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {

        guard let uid else { return }

        db.collection("users")
            .document(uid)
            .collection("addresses")
            .document(id)
            .delete { error in

                if let error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }


    func setDefaultAddress(
        id: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {

        guard let uid else { return }

        let ref = db.collection("users")
            .document(uid)
            .collection("addresses")

        ref.getDocuments { snapshot, error in

            if let error {
                completion(.failure(error))
                return
            }

            let batch = self.db.batch()

            snapshot?.documents.forEach { doc in

                batch.updateData(
                    ["isDefault": doc.documentID == id],
                    forDocument: doc.reference
                )
            }

            batch.commit { error in

                if let error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }
}
