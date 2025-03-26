//
//  SummaryView.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-15.
//

import SwiftUI

struct SummaryView: View {
    private let transaction: Transaction
    
    private struct Constants {
        static let columnWidth150: CGFloat = 150
    }
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            headerTitle
            headerRow
            earningsRow
            feesRow
            netEarningsRow
        }
        .padding(.horizontal)
    }
    
    private var headerTitle: some View {
        Text("Earnings and Fees")
            .font(.headline)
            .bold()
            .padding(.bottom, 5)
    }
    
    private var headerRow: some View {
        HStack {
            Text("Date").bold()
                .frame(width: Constants.columnWidth150, alignment: .leading)
            Text("Description").bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Amount").bold()
                .frame(width: Constants.columnWidth150, alignment: .trailing)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
    
    private var earningsRow: some View {
        HStack(alignment: .top) {
            Text(transaction.date.formattedDate)
                .frame(width: Constants.columnWidth150, alignment: .leading)
            Text("Contract Earnings")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("$\(transaction.contractEarnings, specifier: "%.2f")")
                .frame(width: Constants.columnWidth150, alignment: .trailing)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
    
    private var feesRow: some View {
        HStack(alignment: .top) {
            Text(transaction.date.formattedDate)
                .frame(width: Constants.columnWidth150, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 8) { // Group both rows together
                serviceFeeRow
                gstTaxRow
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
    
    private var serviceFeeRow: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Service Fee")
                Text("$\(transaction.contractEarnings, specifier: "%.2f") x \(transaction.servicePercentage, specifier: "%.1f")% = $\(serviceFee, specifier: "%.2f")")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("-$\(serviceFee, specifier: "%.2f")")
                .frame(alignment: .trailing)
        }
    }
    
    private var gstTaxRow: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 2) {
                Text("GST (CA) service fee refund")
                Text("$\(serviceFee, specifier: "%.2f") x \(transaction.taxPercentage, specifier: "%.1f")% = $\(gstTaxAmount, specifier: "%.2f")")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("-$\(gstTaxAmount, specifier: "%.2f")")
                .frame(alignment: .trailing)
        }
    }
    
    private var netEarningsRow: some View {
        HStack {
            Text("Net Earnings").bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("$\(transaction.netEarnings, specifier: "%.2f")").bold()
                .frame(width: 100, alignment: .trailing)
        }
        .padding()
        .background(Color.green.opacity(0.2))
        .cornerRadius(8)
    }
    
    private var serviceFee: Double {
        (transaction.servicePercentage / 100) * transaction.contractEarnings
    }
    
    private var gstTaxAmount: Double {
        (transaction.taxPercentage / 100) * serviceFee
    }
}

#Preview {
    SummaryView(transaction: .sampleTransaction)
}
