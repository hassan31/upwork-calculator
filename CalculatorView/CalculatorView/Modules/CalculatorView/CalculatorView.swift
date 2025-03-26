//
//  CalculatorView.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-15.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    
    var body: some View {
        mainContent
    }
    
    private var mainContent: some View {
        VStack(spacing: 20) {
            headerView
            inputView
            buttonView
            summaryView
            Spacer()
        }
        .padding()
        .multilineTextAlignment(.center)
        .background(Color.white.opacity(0.9))
    }
    
    private var headerView: some View {
        VStack(spacing: 20) {
            Text("Upwork Earnings Calculator")
                .multilineTextAlignment(.center)
                .font(.title)
                .bold()
            HStack {
                datePickerView
                paymentTypePicker
                transactionStatusPicker
            }
            .padding(.horizontal)
        }
    }
    
    private var datePickerView: some View {
        VStack(spacing: 8) {
            Text("Select Date")
                .font(.headline)
            DatePicker("", selection: $viewModel.selectedDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .labelsHidden()
        }
    }
    
    private var paymentTypePicker: some View {
        VStack(spacing: 8) {
            Text("Payment Type")
                .font(.headline)
            
            Picker("Payment Type", selection: $viewModel.paymentType) {
                ForEach(PaymentType.allCases) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    private var transactionStatusPicker: some View {
        VStack(spacing: 8) {
            Text("Transaction Status")
                .font(.headline)
            
            Picker("Transaction Status", selection: $viewModel.transactionStatus) {
                ForEach(TransactionStatus.allCases) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    private var inputView: some View {
        HStack(spacing: 24) {
            TextField("Transaction id", text: $viewModel.transactionId)
                .font(.system(size: 20, weight: .bold))
                .platformSpecificStyle()
                .padding(.vertical)
            
            TextField("Client name", text: $viewModel.clientDescription)
                .font(.system(size: 20, weight: .bold))
                .platformSpecificStyle()
                .padding(.vertical)
            
            TextField("Amount", text: $viewModel.inputAmount)
                .font(.system(size: 20, weight: .bold))
                .platformSpecificStyle()
                .onChange(of: viewModel.inputAmount, { oldValue, newValue in
                    if newValue.isEmpty {
                        viewModel.inputAmount = ""
                    } else if !newValue.hasPrefix("$") {
                        viewModel.inputAmount = "$" + newValue.replacingOccurrences(of: "$", with: "")
                    }
                    viewModel.updateTransaction()
                })
                .padding(.vertical)
        }
        .padding(.horizontal)
    }
    
    private var buttonView: some View {
        HStack {
            Spacer()
            Button {
                viewModel.submitTransaction()
            } label: {
                Text("Submit")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200)
                    .padding(16)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .buttonStyle(.plain)
            .padding(.horizontal)
            .disabled(!viewModel.enableCalculateButton)
        }
    }
    
    @ViewBuilder
    private var summaryView: some View {
        if let transaction: Transaction = viewModel.newTransaction {
            SummaryView(transaction: transaction)
        }
    }
}

#Preview {
    CalculatorView()
        .frame(width: 500, height: 600)
}
