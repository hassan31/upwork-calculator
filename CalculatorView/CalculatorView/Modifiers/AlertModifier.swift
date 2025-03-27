//
//  AlertModifier.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-27.
//

import SwiftUI

struct AlertModifier: ViewModifier {
    @Binding private var isPresented: Bool
    private let state: AlertState?
    private let completion: (() -> Void)?
    
    init(isPresented: Binding<Bool>, state: AlertState?, completion: (() -> Void)?) {
        self._isPresented = isPresented
        self.state = state
        self.completion = completion
    }

    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text(state?.title ?? "Alert"),
                    message: Text(state?.message ?? ""),
                    dismissButton: .default(Text("OK"), action: {
                        completion?()
                    })
                )
            }
    }
}

extension View {
    func showAlert(isPresented: Binding<Bool>,
                   state: AlertState?,
                   completion: (() -> Void)? = nil) -> some View {
        self.modifier(
            AlertModifier(isPresented: isPresented, state: state, completion: completion)
        )
    }
}
