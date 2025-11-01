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
    @Query private var expenses :[Expense]
    @Environment(\.dismiss) private var dismiss
    
      private var startingBalance: Decimal {
          settings.first?.startingBalance ?? 0
      }

      private var totalSpent: Decimal {
          expenses.reduce(0) { $0 + $1.amount }
      }

      private var currentBalance: Decimal {
          startingBalance - totalSpent
      }

    var body: some View {
        NavigationStack{
            Form{
                Section(header:Text("Balance Details")){
                    HStack{
                        Text("Starting Balance")
                        Spacer()
                        Text("₹\(formatCurrency(startingBalance))")
                            .foregroundColor(Color.green)
                        
                    }
                    HStack{
                        Text("Total Spent ")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("₹\(formatCurrency(totalSpent))")
                            .foregroundColor(.red)
                    }
                    HStack{
                        Text("Current Balance")
                            .fontWeight(.bold)
                        Spacer()
                        Text("₹\(formatCurrency(currentBalance))")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                }
                Section(header: Text("About")) {
                                      HStack {
                                          Text("Version")
                                          Spacer()
                                          Text("1.0.0")
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
