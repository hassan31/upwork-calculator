//
//  LoadingModifier.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-25.
//

import SwiftUI

struct LoadingModifier: ViewModifier {
    var isLoading: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
                .blur(radius: isLoading ? 3 : 0)
            
            if isLoading {
                VStack {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(width: 80, height: 80)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.3))
            }
        }
    }
}

// Extension for easy use
extension View {
    func showLoading(_ isLoading: Bool) -> some View {
        self.modifier(LoadingModifier(isLoading: isLoading))
    }
}
