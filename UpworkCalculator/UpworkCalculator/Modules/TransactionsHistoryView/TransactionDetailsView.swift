//
//  TransactionDetailsView.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-26.
//

import SwiftUI

struct TransactionDetailsView: View {
    private let viewModel: TransactionDetailsViewModel
    
    init(transaction: Transaction) {
        self.viewModel = TransactionDetailsViewModel(transaction: transaction)
    }
    
    var body: some View {
        mainContent
    }
    
    private var mainContent: some View {
        VStack {
            contractInfoView
            SummaryView(transaction: viewModel.transaction)
                .padding(.horizontal)
            Spacer()
        }
    }
    
    private var contractInfoView: some View {
        VStack(spacing: 16) {
            transactionIdView
            HStack(spacing: 32) {
                ForEach(viewModel.contractInfoArray, id: \.id) { item in
                    createInfoView(item: item)
                }
                Spacer()
                StatusView(
                    status: TransactionStatus(
                        rawValue: viewModel.transaction.transactionStatus
                    ) ?? .pending
                )
            }
            Divider()
        }
        .padding(32)
    }
    
    private var transactionIdView: some View {
        HStack {
            Text("Transaction Id:")
                .font(.body)
                .foregroundStyle(.gray)
            Text(viewModel.transaction.transactionId)
                .font(.body)
                .fontWeight(.bold)
                .foregroundStyle(.gray)
            Spacer()
        }
    }
    
    private func createInfoView(item: ContractInfoItem) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.label)
                .font(.headline)
                .foregroundStyle(.gray)
            Text(item.value)
                .font(.system(size: 20))
        }
    }
}

#Preview {
    TransactionDetailsView(transaction: .sampleTransaction)
}
