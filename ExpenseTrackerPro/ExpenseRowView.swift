//
//  ExpenseRowView.swift
//  ExpenseTrackerPro
//
//  Created by shalinth adithyan on 01/11/25.
//


import SwiftUI

struct ExpenseRowView: View {
    var expense: Expense

    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(expense.transactionType == .income ? Color.green : Color.red)
                .frame(width: 4)
                .cornerRadius(2)

            HStack(spacing: 12) {
                categoryIcon
                    .frame(width: 45, height: 45)
                    .background(
                        Circle()
                            .fill(categoryColor.opacity(0.15))
                    )

                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(expense.category)
                            .font(.headline)
                            .foregroundStyle(.primary)

                        Text(expense.transactionType == .income ? "Income" : "Expense")
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(
                                Capsule()
                                    .fill(expense.transactionType == .income ? Color.green :Color.red)
                            )
                    }

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

                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(expense.transactionType == .income ? "+" :"-")₹\(formatCurrency(expense.amount))")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(expense.transactionType == .income ? .green : .red)

                    Image(systemName: expense.transactionType == .income ? "arrow.up.circle.fill"
 : "arrow.down.circle.fill")
                        .font(.caption)
                        .foregroundColor(expense.transactionType == .income ? .green.opacity(0.7)
 : .red.opacity(0.7))
                }
            }
            .padding(.leading, 12)
            .padding(.vertical, 12)
        }
        .background(Color(.systemBackground))
    }

    private var categoryIcon: some View {
        Image(systemName: getCategoryIcon())
            .font(.system(size: 22))
            .foregroundColor(categoryColor)
    }

    private var categoryColor: Color {
          switch expense.category {
          case "Food":
              return .orange
          case "Transport":
              return .blue
          case "Shopping":
              return .purple
          case "Bills":
              return .red
          case "Gym":
              return .green
          case "Entertainment":
              return .pink
          case "Health":
              return .red
          case "Education":
              return .blue
          default:
              return .gray
          }
      }


    private func getCategoryIcon() -> String {
          switch expense.category {
          case "Food":
              return "fork.knife"
          case "Transport":
              return "car.fill"
          case "Shopping":
              return "cart.fill"
          case "Bills":
              return "doc.text.fill"
          case "Gym":
              return "dumbbell.fill"
          case "Entertainment":
              return "popcorn.fill"
          case "Health":
              return "heart.fill"
          case "Education":
              return "book.fill"
          default:
              return "star.fill"
          }
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
    VStack(spacing: 10) {
        ExpenseRowView(expense: Expense(
            amount: Decimal(500),
            category: "Food",
            date: Date(),
            notes: "Lunch at restaurant",
            type: .expense
        ))

        ExpenseRowView(expense: Expense(
            amount: Decimal(50000),
            category: "Other",
            date: Date(),
            notes: "Monthly salary",
            type: .income
        ))
    }
}

