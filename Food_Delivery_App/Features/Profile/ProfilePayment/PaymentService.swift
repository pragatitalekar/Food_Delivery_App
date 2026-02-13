//
//  PaymentService.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/12/26.
//


import FirebaseFirestore
import FirebaseAuth

final class PaymentService {
    static let shared = PaymentService()
    private let db = Firestore.firestore()
    private init() {}

    func fetchMethods(uid: String, completion: @escaping (Result<[PaymentMethod], Error>) -> Void) {
        
        db.collection("users")
            .document(uid)
            .collection("paymentMethods")
            .getDocuments { snapshot, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                let methods = snapshot?.documents.compactMap { doc -> PaymentMethod? in
                    
                    let data = doc.data()
                    
                    return PaymentMethod(
                        id: doc.documentID,
                        type: data["type"] as? String ?? "",
                        holderName: data["holderName"] as? String ?? "",
                        number: data["number"] as? String ?? "",
                        expiryDate: data["expiryDate"] as? String,
                        cvv: data["cvv"] as? String,
                        ifsc: data["ifsc"] as? String
                    )
                } ?? []
                
                completion(.success(methods))
            }
    }


    func deleteMethod(uid: String, id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users").document(uid).collection("paymentMethods").document(id).delete { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
}
