//
//  DefaultTextFieldStyle.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-26.
//

import SwiftUI

struct DefaultTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(height: 50)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
    }
}

extension View {
    func style(_ style: DefaultTextFieldStyle) -> some View {
        modifier(style)
    }
}

extension DefaultTextFieldStyle {
    static var `default`: DefaultTextFieldStyle {
        DefaultTextFieldStyle()
    }
}
