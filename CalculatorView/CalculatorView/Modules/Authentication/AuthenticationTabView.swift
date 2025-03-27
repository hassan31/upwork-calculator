//
//  AuthenticationTabView.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-26.
//

import SwiftUI

struct AuthenticationTabView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        TabView {
            LoginView(viewModel: loginViewModel)
                .tabItem {
                    Label("Login", systemImage: "person.fill")
                }
            
            RegisterView()
                .tabItem {
                    Label("Register", systemImage: "person.badge.plus.fill")
                }
        }
    }
}

#Preview {
    AuthenticationTabView()
}
