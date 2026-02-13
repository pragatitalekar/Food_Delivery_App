//
//  ProfileService.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/6/26.
//
import FirebaseFirestore
import FirebaseAuth

final class ProfileService {
    
    static let shared = ProfileService()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    // MARK: Fetch Profile
    
    func fetchProfile(uid: String,
                      completion: @escaping (Result<[String: Any], Error>) -> Void) {
        
        db.collection("users")
            .document(uid)
            .getDocument { snapshot, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = snapshot?.data() else {
                    completion(.success([:]))
                    return
                }
                
                completion(.success(data))
            }
    }
    
    
    // MARK: Update Profile
    
    func updateProfile(uid: String,
                       data: [String: Any],
                       completion: @escaping (Result<Void, Error>) -> Void) {
        
        print("SERVICE: updating profile for:", uid)
        print("SERVICE DATA:", data)
        
        db.collection("users")
            .document(uid)
            .setData(data, merge: true) { error in
                
                if let error = error {
                    print("SERVICE ERROR:", error.localizedDescription)
                    completion(.failure(error))
                    return
                }
                
                print("SERVICE SUCCESS: profile updated")
                completion(.success(()))
            }
    }
    
}

