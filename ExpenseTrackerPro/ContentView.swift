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
    private var hasCompletedOnboarding: Bool {
          settings.first?.hasCompletedOnboarding ?? false
      }
    private var totalSpent:Decimal {
        expenses.reduce(0){
            $0+$1.amount
        }
    }
    
    private var startingBalance: Decimal {
          settings.first?.startingBalance ?? 10000
      }
    
    private var currentBalance: Decimal {
        startingBalance - totalSpent
    }
    @State private var showSettings = false
    @State private var showAddExpense = false
    var body: some View {
        if hasCompletedOnboarding {
            NavigationStack{
                VStack{
                    BalanceCardView(balance: currentBalance, spent: totalSpent)
                    
                    HStack{
                        Text("Expenses")
                            .bold()
                        Spacer()
                        Button(action: { }) {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                    
                    List{
                        ForEach(expenses){expense in
                            ExpenseRowView(expense:expense)
                        }
                        .onDelete(perform: deleteExpenses)
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
                            Button(action: { showAddExpense = true}) {
                                Image(systemName: "plus").sheet(isPresented: $showAddExpense) {
                                    AddExpenseView()
                                }
                            }
                            
                            Button(action: {showSettings = true }) {
                                Image(systemName: "gearshape")
                            }
                        }
                    }
                }
            }
        }else {
           
            OnboardingView()
        }
    }

        
        
        private func deleteExpenses(at offsets: IndexSet) {
            for index in offsets {
                let expense = expenses[index]
                modelContext.delete(expense)
            }
        }
    }



#Preview {
    ContentView()
}
