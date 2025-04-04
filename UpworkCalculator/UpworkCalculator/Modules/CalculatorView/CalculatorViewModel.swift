//
//  CalculatorViewModel.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-19.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class CalculatorViewModel: ObservableObject {
    @Published var inputAmount: String = ""
    @Published var transactionId: String = ""
    @Published var clientDescription: String = ""
    @Published var selectedDate: Date = Date()
    @Published var paymentType: PaymentType = .fixedPrice
    @Published var transactionStatus: TransactionStatus = .pending
    @Published var newTransaction: Transaction?
    @Published var alert: AlertState?
    @Published var showAlert: Bool = false
    
    var enableCalculateButton: Bool {
        !inputAmount.isEmpty && !transactionId.isEmpty && !clientDescription.isEmpty
    }
    
    private let db = Firestore.firestore()
    let serviceFee: Double = 10.0
    let taxPercentage: Double = 13.0
    
    func updateTransaction() {
        guard let contractEarnings = Double(inputAmount.replacingOccurrences(of: "$", with: "")) else { return }

        let serviceFee = (serviceFee / 100) * contractEarnings
        let gstAmount = (taxPercentage / 100) * serviceFee
        let netEarnings = contractEarnings - serviceFee - gstAmount

        newTransaction = Transaction(
            date: selectedDate,
            transactionId: transactionId,
            clientDescription: clientDescription,
            contractEarnings: contractEarnings,
            netEarnings: netEarnings
        )
    }
    
    func submitTransaction() {
        guard let newTransaction else {
            print("New transaction is nil")
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let transactionData: [String: Any] = [
            "date": Timestamp(date: newTransaction.date),
            "transactionId": newTransaction.transactionId,
            "clientDescription": newTransaction.clientDescription,
            "contractEarnings": newTransaction.contractEarnings,
            "netEarnings": newTransaction.netEarnings,
            "paymentType": paymentType.rawValue,
            "servicePercentage": newTransaction.servicePercentage,
            "taxPercentage": newTransaction.taxPercentage,
            "transactionStatus": transactionStatus.rawValue
        ]
        
        db.collection("users")
            .document(userId)
            .collection("transactions")
            .addDocument(data: transactionData) { [weak self] error in
                guard let self else {
                    return
                }
                
                if let error {
                    alert = .error("Firestore Error: \(error.localizedDescription)")
                } else {
                    alert = .success("Transaction successfully saved")
                    self.clear()
                }
                showAlert = true
            }
    }
    
    func clear() {
        inputAmount = ""
        transactionId = ""
        clientDescription = ""
        paymentType = .fixedPrice
        transactionStatus = .pending
        newTransaction = nil
    }
}
