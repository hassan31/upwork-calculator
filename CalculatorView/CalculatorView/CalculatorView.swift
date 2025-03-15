//
//  CalculatorView.swift
//  CalculatorView
//
//  Created by Muhammad Hassan on 2025-03-15.
//

import SwiftUI

struct CalculatorView: View {
    @State private var amount: String = ""
    @State private var finalAmount: Double? = nil
    
    private let upworkFeePercentage: Double = 10.0
    private let taxPercentage: Double = 13.0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("💰 Upwork Earnings Calculator")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.blue)
            
            // Input & Button Row
            HStack {
                TextField("Enter amount", text: $amount)
                    .platformSpecificStyle()
                    .frame(maxWidth: 200)
                
                Button(action: calculateFinalAmount) {
                    Text("Calculate")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal)

            // Summary Table View
            if let totalAmount = Double(amount) {
                SummaryView(totalAmount: totalAmount, feePercentage: upworkFeePercentage, taxPercentage: taxPercentage)
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: 600)
        .multilineTextAlignment(.center)
        .background(Color.white.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 5)
        .padding()
    }
    
    private func calculateFinalAmount() {
        guard let _ = Double(amount) else { return }
        finalAmount = Double(amount)
    }
}

// Summary Table
struct SummaryView: View {
    let totalAmount: Double
    let feePercentage: Double
    let taxPercentage: Double
    
    var serviceFee: Double {
        (feePercentage / 100) * totalAmount
    }
    
    var gstAmount: Double {
        (taxPercentage / 100) * serviceFee
    }
    
    var netEarnings: Double {
        totalAmount - serviceFee + gstAmount
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("📊 Earnings and Fees")
                .font(.headline)
                .bold()
                .padding(.bottom, 5)
            
            // Header Row
            HStack {
                Text("Date").bold()
                    .frame(width: 100, alignment: .leading)
                Text("Description").bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Amount").bold()
                    .frame(width: 100, alignment: .trailing)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            
            // Earnings Row
            HStack(alignment: .top) {  // Top alignment ensures date stays at the top
                Text(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none))
                    .frame(width: 100, alignment: .leading)
                Text("Contract Earnings")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("$\(totalAmount, specifier: "%.2f")")
                    .frame(width: 100, alignment: .trailing)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            
            // Fees Row (Service Fee + GST)
            HStack(alignment: .top) { // Ensure top alignment
                Text(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none))
                    .frame(width: 100, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 8) { // Group both rows together
                    // Service Fee Row
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Service Fee")
                            Text("$\(totalAmount, specifier: "%.2f") x \(feePercentage, specifier: "%.1f")% = $\(serviceFee, specifier: "%.2f")")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("-$\(serviceFee, specifier: "%.2f")")
                            .frame(alignment: .trailing)
                    }
                    
                    // GST Row
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("GST (CA) service fee refund")
                            Text("$\(serviceFee, specifier: "%.2f") x \(taxPercentage, specifier: "%.1f")% = $\(gstAmount, specifier: "%.2f")")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("-$\(gstAmount, specifier: "%.2f")")
                            .frame(alignment: .trailing)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)

            // Net Earnings Row
            HStack {
                Text("Net Earnings").bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("$\(netEarnings, specifier: "%.2f")").bold()
                    .frame(width: 100, alignment: .trailing)
            }
            .padding()
            .background(Color.green.opacity(0.2))
            .cornerRadius(8)
        }
        .padding(.horizontal)
    }
}

// Platform-Specific TextField Style
struct PlatformSpecificModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.platformBackground)
            .cornerRadius(10)
            .shadow(radius: 3)
            #if os(iOS)
            .keyboardType(.decimalPad)
            #endif
    }
}

extension View {
    func platformSpecificStyle() -> some View {
        self.modifier(PlatformSpecificModifier())
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .frame(width: 500, height: 600)
    }
}
