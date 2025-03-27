//
//  TransactionsHistoryViewModel.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-19.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class TransactionsHistoryViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var transactions: [Transaction] = []
    @Published var errorAlert: AlertState?
    
    private let db = Firestore.firestore()
    
    func fetchTransactions() {
        if transactions.isEmpty {
            guard let userId = Auth.auth().currentUser?.uid else { return }
            
            isLoading = true
            db.collection("users").document(userId).collection("transactions")
                .order(by: "date", descending: true)
                .addSnapshotListener { [weak self] snapshot, error in
                    guard let self else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.isLoading = false
                        
                        if let error = error {
                            self.errorAlert = .error("Error fetching transactions: \(error.localizedDescription)")
                            return
                        }
                        
                        if let documents = snapshot?.documents {
                            self.transactions = documents.compactMap {
                                try? $0.data(as: Transaction.self)
                            }
                            .sorted { $0.date > $1.date }
                        }
                    }
                }
        }
    }
}
