//
//  ContentView.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-15.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appViewModel = ContentViewModel()
    
    var body: some View {
        if let _ = appViewModel.user {
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
}

#Preview {
    ContentView()
}
