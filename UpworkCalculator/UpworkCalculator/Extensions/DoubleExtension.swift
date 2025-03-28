//
//  DoubleExtension.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-27.
//

import Foundation

extension Double {
    func formattedAmount(showNegativeSign: Bool = false) -> String {
        var format: String = "$%.2f"
        if showNegativeSign {
            format = "-$%.2f"
        }
        return String(format: format, self)
    }
}
