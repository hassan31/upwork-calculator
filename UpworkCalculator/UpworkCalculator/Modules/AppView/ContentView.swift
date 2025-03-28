//
//  ContentView.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-15.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                emptyView
            } else {
                mainContent
            }
        }
        .showLoading(viewModel.isLoading)
        .environmentObject(viewModel)
    }
    
    @ViewBuilder
    private var mainContent: some View {
        if let _ = viewModel.user {
            TabView {
                CalculatorView()
                    .tabItem {
                        Label("Calculator", systemImage: "dollarsign.circle")
                    }
                
                TransactionsHistoryView()
                    .tabItem {
                        Label("Earnings", systemImage: "list.bullet")
                    }
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle.fill")
                    }
            }
        } else {
            AuthenticationTabView()
        }
    }
    
    private var emptyView: some View {
        EmptyView()
    }
}

#Preview {
    ContentView()
}
