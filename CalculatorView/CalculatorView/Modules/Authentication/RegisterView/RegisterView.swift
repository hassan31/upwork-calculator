//
//  RegisterView.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-26.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()

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
            resgisterButton
        }
        .cardStyle()
    }
    
    private var headerTitle: some View {
        Text("Register")
            .font(.largeTitle)
            .bold()
            .foregroundStyle(Color.primaryColor)
    }
    
    private var textFields: some View {
        VStack(spacing: 15) {
            fullName
            emailField
            passwordField
        }
        .padding(.horizontal, 30)
    }
    
    private var fullName: some View {
        TextField("Full Name", text: $viewModel.fullName)
            .textFieldStyle(.plain)
            .style(.default)
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
    
    private var resgisterButton: some View {
        Button {
            viewModel.registerUser()
        } label: {
            Text("Register")
                .buttonStyle(ButtonStyle(isEnabled: !viewModel.disableRegisterButton))
        }
        .padding(.horizontal, 30)
        .disabled(viewModel.disableRegisterButton)
    }
}

#Preview {
    RegisterView()
}
