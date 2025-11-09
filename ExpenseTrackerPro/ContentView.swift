//
//  ContentView.swift
//  ExpenseTrackerPro
//
//  Created by shalinth adithyan on 01/11/25.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Expense.date,order:.reverse) private var expenses:[Expense]
    @Query private var settings: [AppSettings]
    private var filteredExpenses: [Expense]{
        
        if let category = selectedCategory{
            return expenses.filter{
                $0.category == category
            }
        }
        return expenses
        
    }
    private var hasCompletedOnboarding: Bool {
        settings.first?.hasCompletedOnboarding ?? false
    }
    private var totalIncome: Decimal {
          expenses.filter { $0.transactionType == .income }.reduce(0) {
              $0 + $1.amount
          }
      }

      // Calculate total expenses from all expense transactions
      private var totalExpenses: Decimal {
          expenses.filter { $0.transactionType == .expense }.reduce(0) {
              $0 + $1.amount
          }
      }

      // For backward compatibility (same as totalExpenses)
      private var totalSpent: Decimal {
          totalExpenses
      }

      private var startingBalance: Decimal {
          settings.first?.startingBalance ?? 10000
      }

      // New balance calculation: starting + income - expenses
      private var currentBalance: Decimal {
          startingBalance + totalIncome - totalExpenses
      }

    
    @State private var showSettings = false
    @State private var showAddExpense = false
    @State private var selectedCategory:String? = nil
    
    @State private var showFilter = false

        var body: some View {
            if hasCompletedOnboarding {
                NavigationStack {
                    VStack {
                        BalanceCardView(balance: currentBalance, spent: totalSpent)

                        HStack {
                            if let category = selectedCategory {
                                Text("Expenses - \(category)")
                            } else {
                                Text("Expenses")
                            }

                            Spacer()
                            Button(action: { showFilter = true }) {
                                Image(systemName: "magnifyingglass")
                            }
                        }

                        List {
                            ForEach(filteredExpenses) { expense in
                                ExpenseRowView(expense: expense)
                            }
                            .onDelete(perform: deleteExpenses)

                            Section {
                                HStack {
                                    Text("Total Expenses:")
                                        .fontWeight(.bold)
                                    Spacer()
                                    Text("₹\(formatCurrency(totalSpent))")
                                        .fontWeight(.bold)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    .navigationTitle(Text("Expense Tracker"))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            EditButton()
                        }

                        ToolbarItem(placement: .topBarTrailing) {
                            HStack(spacing: 16) {
                                Button(action: { showAddExpense = true }) {
                                    Image(systemName: "plus")
                                }

                                Button(action: { showSettings = true }) {
                                    Image(systemName: "gearshape")
                                }
                            }
                        }
                    }
                    .sheet(isPresented: $showAddExpense) {
                        AddExpenseView()
                    }
                    .sheet(isPresented: $showSettings) {
                        SettingsView()
                    }
                    .sheet(isPresented: $showFilter) {
                        FilterView(selectedCategory: $selectedCategory)
                    }
                }
            } else {
                OnboardingView()
            }
        }


    private func deleteExpenses(at offsets: IndexSet) {
        for index in offsets {
            let expense = filteredExpenses[index]
            modelContext.delete(expense)
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
    ContentView()
}
