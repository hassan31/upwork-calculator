//
//  TransactionModel.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-25.
//

import FirebaseFirestore

struct Transaction: Identifiable, Codable {
    @DocumentID var id: String?
    var date: Date
    var transactionId: String
    var clientDescription: String
    var contractEarnings: Double
    var netEarnings: Double
    var paymentType: String = PaymentType.fixedPrice.rawValue
    var servicePercentage: Double = 10.0
    var taxPercentage: Double = 13.0
    var transactionStatus: String = TransactionStatus.pending.rawValue
}

extension Transaction {
    static var sampleTransaction: Transaction {
        Transaction(
            id: "1234",
            date: Date(),
            transactionId: "12345",
            clientDescription: "Client Name",
            contractEarnings: 500.0,
            netEarnings: 454.43,
            paymentType: PaymentType.fixedPrice.rawValue,
            servicePercentage: 10.0,
            taxPercentage: 13.0,
            transactionStatus: TransactionStatus.pending.rawValue
        )
    }
}
