//
//  ColorExtension.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-15.
//

import SwiftUI

extension Color {
    static var platformBackground: Color {
        #if os(iOS)
        return Color(.systemGray6)
        #else
        return Color.gray.opacity(0.2) // macOS alternative
        #endif
    }
    
    static var primaryColor: Color {
        Color("primary")
    }
}
