//
//  SettingsView.swift
//  ExpenseTrackerPro
//
//  Created by shalinth adithyan on 01/11/25.
//
import SwiftData
  import SwiftUI

  struct SettingsView: View {
      @Query private var settings: [AppSettings]
      @Query private var expenses: [Expense]
      @Query private var customCategories: [CustomCategory]
      @Environment(\.dismiss) private var dismiss
      @Environment(\.colorScheme) var colorScheme

      private var startingBalance: Decimal {
          settings.first?.startingBalance ?? 0
      }

      private var totalIncome: Decimal {
          expenses.filter { $0.transactionType == .income }.reduce(0) { $0 + $1.amount }
      }

      private var totalExpenses: Decimal {
          expenses.filter { $0.transactionType == .expense }.reduce(0) { $0 + $1.amount }
      }

      private var currentBalance: Decimal {
          startingBalance + totalIncome - totalExpenses
      }

      var body: some View {
          NavigationStack {
              Form {
                  Section {
                      VStack(spacing: 16) {
                          VStack(spacing: 4) {
                              Text("Current Balance")
                                  .font(.subheadline)
                                  .foregroundColor(.secondary)
                              Text("₹\(formatCurrency(currentBalance))")
                                  .font(.system(size: 36, weight: .bold, design: .rounded))
                                  .foregroundColor(.primary)
                          }

                          Divider()

                          HStack(spacing: 20) {
                              VStack(spacing: 4) {
                                  HStack(spacing: 4) {
                                      Image(systemName: "arrow.up.circle.fill")
                                          .foregroundColor(.green)
                                      Text("Income")
                                          .font(.caption)
                                          .foregroundColor(.secondary)
                                  }
                                  Text("₹\(formatCurrency(totalIncome))")
                                      .font(.headline)
                                      .foregroundColor(.green)
                              }
                              .frame(maxWidth: .infinity)

                              Divider()
                                  .frame(height: 40)

                              VStack(spacing: 4) {
                                  HStack(spacing: 4) {
                                      Image(systemName: "arrow.down.circle.fill")
                                          .foregroundColor(.red)
                                      Text("Expense")
                                          .font(.caption)
                                          .foregroundColor(.secondary)
                                  }
                                  Text("₹\(formatCurrency(totalExpenses))")
                                      .font(.headline)
                                      .foregroundColor(.red)
                              }
                              .frame(maxWidth: .infinity)
                          }
                      }
                      .padding(.vertical, 8)
                  }

                  Section(header: Text("Balance Details")) {
                      HStack {
                          Text("Starting Balance")
                          Spacer()
                          Text("₹\(formatCurrency(startingBalance))")
                              .foregroundColor(.blue)
                      }

                      HStack {
                          Text("Total Transactions")
                          Spacer()
                          Text("\(expenses.count)")
                              .foregroundColor(.secondary)
                      }
                  }

                  if !customCategories.isEmpty {
                      Section(header: Text("Custom Categories")) {
                          ForEach(customCategories.filter { $0.isActive }, id: \.id) { category in
                              HStack {
                                  Image(systemName: "star.fill")
                                      .foregroundColor(.yellow)
                                  Text(category.name)
                                  Spacer()
                                  Text("\(category.usageCount) uses")
                                      .font(.caption)
                                      .foregroundColor(.secondary)
                              }
                          }

                          ForEach(customCategories.filter { !$0.isActive }, id: \.id) { category in
                              HStack {
                                  Image(systemName: "clock")
                                      .foregroundColor(.orange)
                                  Text(category.name)
                                  Spacer()
                                  Text("\(category.usageCount)/4")
                                      .font(.caption)
                                      .foregroundColor(.secondary)
                              }
                          }
                      }
                  }

                  Section(header: Text("About")) {
                      HStack {
                          Text("Version")
                          Spacer()
                          Text("2.0.0")
                              .foregroundColor(.gray)
                      }

                      HStack {
                          Text("Theme")
                          Spacer()
                          Text(colorScheme == .dark ? "Dark Mode" : "Light Mode")
                              .foregroundColor(.gray)
                      }
                  }
              }
              .navigationTitle("Settings")
              .navigationBarTitleDisplayMode(.inline)
              .toolbar {
                  ToolbarItem(placement: .topBarTrailing) {
                      Button("Done") {
                          dismiss()
                      }
                  }
              }
          }
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
      SettingsView()
  }

#Preview {
    SettingsView()
}
