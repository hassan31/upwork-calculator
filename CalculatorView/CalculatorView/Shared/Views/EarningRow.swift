//
//  EarningRow.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-15.
//

import SwiftUI

struct EarningRowView: View {
    private let transaction: Transaction
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(transaction.date.formattedDate)
                    .font(.title3)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Text(transaction.clientDescription)
                    .font(.title3)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                StatusView(status: TransactionStatus(rawValue: transaction.transactionStatus) ?? .pending)
                Spacer()
                Text("$\(transaction.netEarnings, specifier: "%.2f")")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.green)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SummaryView(transaction: .sampleTransaction)
}
