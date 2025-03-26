//
//  TransactionStatus.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-25.
//

import Foundation

enum TransactionStatus: String, CaseIterable, Identifiable {
    case pending = "Pending"
    case processed = "Processed"

    var id: String { self.rawValue }
}
