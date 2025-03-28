//
//  AuthenticationManager.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-26.
//

import FirebaseAuth
import FirebaseFirestore

class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    /// Register New User
    func register(fullName: String, email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let uid = result?.user.uid {
                let userData: [String: Any] = [
                    "fullName": fullName,
                    "email": email,
                    "createdAt": Timestamp()
                ]
                self.db.collection("users").document(uid).setData(userData) { firestoreError in
                    if let firestoreError = firestoreError {
                        completion(.failure(firestoreError))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
    }

    /// Login Existing User
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    /// Logout User
    func logout() {
        try? auth.signOut()
    }
}
