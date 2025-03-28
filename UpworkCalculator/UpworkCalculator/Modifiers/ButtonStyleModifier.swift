//
//  ButtonStyleModifier.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-26.
//

import SwiftUI

struct ButtonStyleModifier: ViewModifier {
    private let style: ButtonStyle
    
    init(style: ButtonStyle) {
        self.style = style
    }
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(style.isEnabled ? style.backgroundColor : style.disabledBackgroundColor)
            .foregroundColor(.white)
            .font(.system(size: 20, weight: .medium))
            .cornerRadius(10)
    }
}

extension View {
    func buttonStyle(_ style: ButtonStyle) -> some View {
        modifier(
            ButtonStyleModifier(style: style)
        )
    }
}

struct ButtonStyle {
    let isEnabled: Bool
    let backgroundColor: Color
    let disabledBackgroundColor: Color
    
    init(isEnabled: Bool = true,
         backgroundColor: Color = .primaryColor,
         disabledBackgroundColor: Color = .gray) {
        self.isEnabled = isEnabled
        self.backgroundColor = backgroundColor
        self.disabledBackgroundColor = disabledBackgroundColor
    }
}
