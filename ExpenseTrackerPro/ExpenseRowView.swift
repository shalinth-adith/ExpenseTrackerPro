//
//  ExpenseRowView.swift
//  ExpenseTrackerPro
//
//  Created by shalinth adithyan on 01/11/25.
//

import SwiftUI

struct ExpenseRowView: View {
    var expense:Expense
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing:6){
                Text(expense.category)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(formatDate(expense.date))
                    .font(.caption)
                    .foregroundStyle(.gray)
                if let notes = expense.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                
            }
            Spacer()
            Text("-₹\(formatCurrency(expense.amount))")
                .font(.headline)
                .foregroundColor(.red)
        }
        .padding()
        
    }
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
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
    let sampleExpense = Expense(
          amount: Decimal(500),
          category: "Food",
          date: Date(),
          notes: "Lunch at restaurant"
      )
    return ExpenseRowView(expense: sampleExpense)

}
