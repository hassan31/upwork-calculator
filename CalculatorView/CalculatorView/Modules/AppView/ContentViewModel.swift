//
//  ContentViewModel.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-26.
//

import Foundation
import FirebaseAuth

final class ContentViewModel: ObservableObject {
    @Published var user: FirebaseAuth.User?

    private var authListener: AuthStateDidChangeListenerHandle?

    init() {
        authListener = Auth.auth().addStateDidChangeListener { _, user in
            DispatchQueue.main.async {
                self.user = user
            }
        }
    }

    func logout() {
        try? Auth.auth().signOut()
        self.user = nil
    }
}
