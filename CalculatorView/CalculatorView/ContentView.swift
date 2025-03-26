//
//  ContentView.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CalculatorView()
                .tabItem {
                    Label("Calculator", systemImage: "dollarsign.circle")
                }
            
            TransactionsHistoryView()
                .tabItem {
                    Label("Earnings", systemImage: "list.bullet")
                }
        }
    }
}

#Preview {
    ContentView()
}
