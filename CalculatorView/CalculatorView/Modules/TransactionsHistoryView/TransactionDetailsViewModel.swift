//
//  TransactionDetailsViewModel.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-26.
//

import Foundation

struct ContractInfoItem: Identifiable {
    let id: UUID
    let label: String
    let value: String
    
    init(id: UUID = UUID(), label: String, value: String) {
        self.id = id
        self.label = label
        self.value = value
    }
}

final class TransactionDetailsViewModel {
    var transaction: Transaction
    var contractInfoArray: [ContractInfoItem] = []
    
    init(transaction: Transaction) {
        self.transaction = transaction
        self.contractInfoArray = buildContractInfoArray()
    }
    
    private func buildContractInfoArray() -> [ContractInfoItem] {
        [
            ContractInfoItem(
                label: "Date",
                value: transaction.date.formattedDate
            ),
            ContractInfoItem(
                label: "Type",
                value: transaction.paymentType
            ),
            ContractInfoItem(
                label: "Client",
                value: transaction.clientDescription
            ),
            ContractInfoItem(
                label: "Amount",
                value: transaction.netEarnings.formattedAmount()
            )
        ]
    }
}
