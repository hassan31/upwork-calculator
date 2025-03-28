//
//  ContentViewModel.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-26.
//

import FirebaseAuth

final class ContentViewModel: ObservableObject {
    @Published var user: FirebaseAuth.User?
    @Published var isLoading: Bool = false

    private let auth = Auth.auth()
    private var authListener: AuthStateDidChangeListenerHandle?

    init() {
        isLoading = true
        authListener = auth.addStateDidChangeListener { _, user in
            DispatchQueue.main.async {
                self.isLoading = false
                self.user = user
            }
        }
    }

    func logout() {
        do {
            try auth.signOut()
            self.user = nil
        } catch {
            print(error)
        }
    }
}
