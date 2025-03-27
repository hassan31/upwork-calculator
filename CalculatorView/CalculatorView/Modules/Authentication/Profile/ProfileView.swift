//
//  ProfileView.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-26.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    VStack(spacing: 10) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                        
                        Text(viewModel.fullName)
                            .font(.title)
                            .bold()
                        
                        Text(viewModel.email)
                            .foregroundColor(.gray)
                    }
                }

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button(action: viewModel.logout) {
                    Text("Logout")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
