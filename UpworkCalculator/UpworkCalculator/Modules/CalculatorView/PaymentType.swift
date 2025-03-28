//
//  Untitled.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-25.
//

import Foundation

enum PaymentType: String, CaseIterable, Identifiable {
    case bonus = "Bonus"
    case hourly = "Hourly"
    case fixedPrice = "Fixed Price"

    var id: String { self.rawValue }
}
