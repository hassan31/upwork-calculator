//
//  LoginView.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-26.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            mainContent
        }
        .showLoading(viewModel.isLoading)
        .showAlert(
            isPresented: $viewModel.showAlert,
            state: viewModel.alertState,
            completion: {
                viewModel.showHomeScreen()
            }
        )
    }
    
    private var mainContent: some View {
        VStack(spacing: 32) {
            headerTitle
            textFields
            loginButton
        }
        .cardStyle()
    }
    
    private var headerTitle: some View {
        Text("Login")
            .font(.largeTitle)
            .bold()
            .foregroundStyle(Color.primaryColor)
    }
    
    private var textFields: some View {
        VStack(spacing: 15) {
            emailField
            passwordField
        }
        .padding(.horizontal, 30)
    }
    
    private var emailField: some View {
        TextField("Email", text: $viewModel.email)
            .textFieldStyle(.plain)
            .style(.default)
    }
    
    private var passwordField: some View {
        SecureField("Password", text: $viewModel.password)
            .textFieldStyle(PlainTextFieldStyle())
            .style(.default)
    }
    
    private var loginButton: some View {
        Button {
            viewModel.loginUser()
        } label: {
            Text("Login")
                .buttonStyle(ButtonStyle(isEnabled: !viewModel.disableLoginButton))
        }
        .padding(.horizontal, 30)
        .disabled(viewModel.disableLoginButton)
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
