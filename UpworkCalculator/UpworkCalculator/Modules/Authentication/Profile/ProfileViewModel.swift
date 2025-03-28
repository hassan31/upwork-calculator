//
//  ProfileViewModel.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-26.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

final class ProfileViewModel: ObservableObject {
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let auth = Auth.auth()
    private let db = Firestore.firestore()

    init() {
        fetchUserProfile()
    }

    func fetchUserProfile() {
        guard let userId = auth.currentUser?.uid else { return }
        isLoading = true
        
        db.collection("users").document(userId).getDocument { snapshot, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else if let data = snapshot?.data() {
                    self.fullName = data["fullName"] as? String ?? "Unknown"
                    self.email = data["email"] as? String ?? "No Email"
                }
            }
        }
    }

    func logout() {
        do {
            try auth.signOut()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
