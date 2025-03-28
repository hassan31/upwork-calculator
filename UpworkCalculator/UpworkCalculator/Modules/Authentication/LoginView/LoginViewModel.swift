//
//  LoginViewModel.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-26.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var alertState: AlertState?
    @Published var showAlert: Bool = false
    
    var disableLoginButton: Bool {
        email.isEmpty || password.isEmpty
    }

    func loginUser() {
        guard email.isValidEmail() else {
            alertState = .warning("Please enter a valid email address.")
            showAlert = true
            return
        }
        
        isLoading = true
        
        AuthenticationManager.shared.login(email: email, password: password) { result in
            self.isLoading = false
            switch result {
            case .success:
                self.alertState = .success("Login Successful!")
                self.showAlert = true
            case .failure(let error):
                self.alertState = .error(error.localizedDescription)
                self.showAlert = true
            }
        }
    }
    
    func showHomeScreen() {
        
    }
}
