//
//  CardStyleModifier.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-27.
//

import SwiftUI

struct CardStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(32)
            .frame(width: 500)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 1))
    }
}

extension View {
    func cardStyle() -> some View {
        self.modifier(CardStyleModifier())
    }
}
