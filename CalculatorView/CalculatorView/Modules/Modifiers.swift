//
//  Modifiers.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-15.
//

import SwiftUI

struct PlatformSpecificModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.platformBackground)
            .cornerRadius(10)
            .shadow(radius: 3)
            #if os(iOS)
            .keyboardType(.decimalPad)
            #endif
    }
}

extension View {
    func platformSpecificStyle() -> some View {
        self.modifier(PlatformSpecificModifier())
    }
}
