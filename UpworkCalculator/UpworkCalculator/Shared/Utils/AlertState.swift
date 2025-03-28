//
//  AlertState.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-27.
//

import SwiftUI

enum AlertState {
    case error(String)
    case success(String)
    case warning(String)
    case info(String)

    var title: String {
        switch self {
        case .error: return "Error"
        case .success: return "Success"
        case .warning: return "Warning"
        case .info: return "Info"
        }
    }

    var message: String {
        switch self {
        case .error(let message),
             .success(let message),
             .warning(let message),
             .info(let message):
            return message
        }
    }
}
