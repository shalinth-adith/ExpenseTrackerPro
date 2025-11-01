//
//  BalanceCardView.swift
//  ExpenseTrackerPro
//
//  Created by shalinth adithyan on 01/11/25.
//

import SwiftUI

struct BalanceCardView: View {
    var balance : Decimal
    var spent : Decimal

    
    var body: some View {
        VStack {
            Text("Balance : ₹\(formatCurrency(balance))")
                .font(.system(size: 45, weight: .bold))
                .foregroundColor(Color(red: 0.20, green: 0.78, blue: 0.35))
            Text("spent : ₹\(formatCurrency(spent))")
                .font(.system(size: 18))
                .foregroundColor(Color(red: 0.20, green: 0.78, blue: 0.35))
            
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 250)
        .background(Color.white)
                  .overlay(
                      RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black))
                  .padding()
    }
    private func formatCurrency(_ amount: Decimal) -> String {
              let number = NSDecimalNumber(decimal: amount)
              let formatter = NumberFormatter()
              formatter.numberStyle = .decimal
              formatter.locale = Locale(identifier: "en_IN")
              formatter.maximumFractionDigits = 0
              return formatter.string(from: number) ?? "0"
          }
      }


#Preview {
    BalanceCardView(balance: 8500, spent :1500)
}
