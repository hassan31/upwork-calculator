//
//  TransactionsHistoryView.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-15.
//

import SwiftUI

struct TransactionsHistoryView: View {
    @StateObject private var viewModel = TransactionsHistoryViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                noTransactionsView
                transactionsList
            }
        }
        .showLoading(viewModel.isLoading)
        .onAppear {
            viewModel.fetchTransactions()
        }
    }
    
    @ViewBuilder
    private var transactionsList: some View {
        if !viewModel.transactions.isEmpty {
            List {
                ForEach(viewModel.transactions, id: \.id) { transaction in
                    NavigationLink(destination: SummaryView(transaction: transaction)) {
                        EarningRowView(transaction: transaction)
                    }
                }
            }
            .navigationTitle("Transaction History")
        }
    }
    
    @ViewBuilder
    private var noTransactionsView: some View {
        if !viewModel.isLoading, viewModel.transactions.isEmpty {
            Text("no transactions found, add some transactions to see here!")
                .font(.system(size: 20, weight: .medium))
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    TransactionsHistoryView()
}
