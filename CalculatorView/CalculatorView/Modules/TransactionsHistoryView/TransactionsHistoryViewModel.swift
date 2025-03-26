//
//  TransactionsHistoryViewModel.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-19.
//

import Foundation
import FirebaseFirestore

final class TransactionsHistoryViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var transactions: [Transaction] = []
    private let db = Firestore.firestore()

    func fetchTransactions() {
        if transactions.isEmpty {
            let db = Firestore.firestore()
            isLoading = true
            db.collection("transactions").getDocuments { [weak self] snapshot, error in
                
                DispatchQueue.main.async {
                    guard let self, let docs = snapshot?.documents else { return }
                    self.isLoading = false
                    
                    if let error = error {
                        print("Error fetching transactions: \(error.localizedDescription)")
                        return
                    }
                    
                    self.transactions = docs.compactMap { doc in
                        let data = doc.data()
                        let id = doc.documentID
                        guard let timestamp = data["date"] as? Timestamp,
                              let transactionId = data["transactionId"] as? String,
                              let clientDescription = data["clientDescription"] as? String,
                              let contractEarnings = data["contractEarnings"] as? Double,
                              let netEarnings = data["netEarnings"] as? Double,
                              let serviceFee = data["servicePercentage"] as? Double,
                              let taxPercentage = data["taxPercentage"] as? Double,
                              let paymentType = data["paymentType"] as? String,
                              let transactionStatus = data["transactionStatus"] as? String else {
                            return nil
                        }
                        
                        return Transaction(
                            id: id,
                            date: timestamp.dateValue(),
                            transactionId: transactionId,
                            clientDescription: clientDescription,
                            contractEarnings: contractEarnings,
                            netEarnings: netEarnings,
                            paymentType: paymentType,
                            servicePercentage: serviceFee,
                            taxPercentage: taxPercentage,
                            transactionStatus: transactionStatus
                        )
                    }
                }
            }
        }
    }
}
