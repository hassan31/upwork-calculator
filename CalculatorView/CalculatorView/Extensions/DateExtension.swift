//
//  DateExtension.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-19.
//

import Foundation

extension Date {
    var formattedDate: String {
        DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .none)
    }
}
