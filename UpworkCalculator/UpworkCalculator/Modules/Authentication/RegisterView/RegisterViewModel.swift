//
//  RegisterViewModel.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-26.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class RegisterViewModel: ObservableObject {
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var alertState: AlertState?
    @Published var showAlert: Bool = false

    var disableRegisterButton: Bool {
        fullName.isEmpty || email.isEmpty || password.isEmpty
    }
    
    func registerUser() {
        guard !fullName.isEmpty, !email.isEmpty, !password.isEmpty else {
            alertState = .warning("All fields are required.")
            showAlert = true
            return
        }
        
        guard email.isValidEmail() else {
            alertState = .warning("Please enter a valid email address.")
            showAlert = true
            return
        }

        isLoading = true
        AuthenticationManager.shared.register(
            fullName: fullName,
            email: email,
            password: password,
            completion: { [weak self] result in
                guard let self else {
                    return
                }
                
                switch result {
                case .success:
                    self.alertState = .success("Register Successful!")
                    self.showAlert = true
                case .failure(let error):
                    self.alertState = .error(error.localizedDescription)
                    self.showAlert = true
                }
            }
        )
    }
    
    func showHomeScreen() {
        
    }
}
