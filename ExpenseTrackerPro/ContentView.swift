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

    @State private var isBalanceCompact = false
    @State private var showSettings = false
    @State private var showAddExpense = false
    @State private var selectedCategory:String? = nil
    
    @State private var showFilter = false

    var body: some View {
          if hasCompletedOnboarding {
              NavigationStack {
                  ScrollView {
                      VStack(spacing: 0) {
                          // Balance Card
                          BalanceCardView(
                              balance: currentBalance,
                              spent: totalExpenses,
                              income: totalIncome,
                              isCompact: isBalanceCompact
                          )
                          .background(
                              GeometryReader { geometry in
                                  Color.clear
                                      .preference(
                                          key: ScrollOffsetPreferenceKey.self,
                                          value: geometry.frame(in: .named("scroll")).minY
                                      )
                              }
                          )

                          HStack {
                              if let category = selectedCategory {
                                  Text("Transactions - \(category)")
                                      .font(.headline)
                              } else {
                                  Text("Transactions")
                                      .font(.headline)
                              }

                              Spacer()

                              Button(action: { showFilter = true }) {
                                  Image(systemName: "line.3.horizontal.decrease.circle")
                                      .font(.title3)
                              }
                          }
                          .padding(.horizontal)
                          .padding(.vertical, 12)
                          .background(Color(.systemBackground))

                          // Transactions List
                          if filteredExpenses.isEmpty {
                              emptyStateView
                          } else {
                              LazyVStack(spacing: 0) {
                                  ForEach(filteredExpenses) { expense in
                                      ExpenseRowView(expense: expense)
                                          .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                              Button(role: .destructive) {
                                                  deleteExpense(expense)
                                              } label: {
                                                  Label("Delete", systemImage: "trash")
                                              }
                                          }

                                      Divider()
                                          .padding(.leading, 60)
                                  }

                                  // Total Section
                                  totalSection
                              }
                          }
                      }
                  }
                  .coordinateSpace(name: "scroll")
                  .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                      withAnimation(.easeInOut(duration: 0.3)) {
                          isBalanceCompact = value < -50
                      }
                  }
                  .navigationTitle("Expense Tracker")
                  .navigationBarTitleDisplayMode(.inline)
                  .toolbar {
                      ToolbarItem(placement: .topBarLeading) {
                          Menu {
                              Button(action: { showFilter = true }) {
                                  Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                              }
                          } label: {
                              Image(systemName: "ellipsis.circle")
                          }
                      }

                      ToolbarItem(placement: .topBarTrailing) {
                          HStack(spacing: 16) {
                              Button(action: { showAddExpense = true }) {
                                  Image(systemName: "plus.circle.fill")
                                      .font(.title3)
                                      .foregroundStyle(.blue)
                              }

                              Button(action: { showSettings = true }) {
                                  Image(systemName: "gearshape.fill")
                                      .font(.title3)
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
    
    private var emptyStateView: some View {
         VStack(spacing: 20) {
             Image(systemName: "tray")
                 .font(.system(size: 60))
                 .foregroundColor(.gray.opacity(0.5))

             Text("No Transactions Yet")
                 .font(.title3)
                 .fontWeight(.semibold)
                 .foregroundColor(.primary)

             Text("Tap the + button to add your first transaction")
                 .font(.subheadline)
                 .foregroundColor(.secondary)
                 .multilineTextAlignment(.center)
                 .padding(.horizontal, 40)
         }
         .frame(maxWidth: .infinity)
         .padding(.vertical, 80)
     }
    private var totalSection: some View {
         VStack(spacing: 12) {
             Divider()
                 .padding(.vertical, 8)

             HStack {
                 VStack(alignment: .leading, spacing: 4) {
                     Text("Total Income")
                         .font(.caption)
                         .foregroundColor(.secondary)
                     Text("₹\(formatCurrency(totalIncome))")
                         .font(.headline)
                         .foregroundColor(.green)
                 }

                 Spacer()

                 VStack(alignment: .trailing, spacing: 4) {
                     Text("Total Expenses")
                         .font(.caption)
                         .foregroundColor(.secondary)
                     Text("₹\(formatCurrency(totalExpenses))")
                         .font(.headline)
                         .foregroundColor(.red)
                 }
             }
             .padding(.horizontal)
             .padding(.vertical, 12)
             .background(Color(.secondarySystemBackground))
             .cornerRadius(12)
             .padding(.horizontal)
             .padding(.bottom, 20)
         }
     }

     private func deleteExpense(_ expense: Expense) {
         modelContext.delete(expense)
     }

     struct ScrollOffsetPreferenceKey: PreferenceKey {
         static var defaultValue: CGFloat = 0

         static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
             value = nextValue()
         }
     }





   
}

#Preview {
    ContentView()
}
