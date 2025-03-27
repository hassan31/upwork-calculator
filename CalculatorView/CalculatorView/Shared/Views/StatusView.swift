//
//  StatusView.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-21.
//

import SwiftUI

struct StatusView: View {
    private let status: TransactionStatus
    
    init (status: TransactionStatus) {
        self.status = status
    }
    
    var body: some View {
        mainContent
            .font(.title3)
            .cornerRadius(16)
    }
    
    private var mainContent: some View {
        switch status {
        case .pending:
            Text(status.rawValue)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .foregroundColor(.red)
                .background(.red.opacity(0.2))
        case .processed:
            Text(status.rawValue)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .foregroundColor(.white)
                .background(Color.primaryColor)
        }
    }
}

#Preview {
    StatusView(status: .pending)
}
