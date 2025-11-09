//
//  AddExpenseView.swift
//  ExpenseTrackerPro
//
//  Created by shalinth adithyan on 01/11/25.
//
import SwiftData
import SwiftUI

struct AddExpenseView: View {
    @State private var amount: String = ""
    @State private var transactionType: TransactionType = .expense
    @State private var selectedCategory: Category = .Food
      @State private var date: Date = Date()
      @State private var notes: String = ""
    @State private var showingAlert = false
      @State private var alertTitle = ""
      @State private var alertMessage = ""
    
    @Environment(\.modelContext)private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    private func showAlert(title: String, message: String) {
          alertTitle = title
          alertMessage = message
          showingAlert = true
      }

    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Type",selection: $transactionType){
                        Text("Expense").tag(TransactionType.expense)
                        Text("Income").tag(TransactionType.income)
                    }
                    .pickerStyle(.segmented)
                }
                Section(header: Text("Amount")) {
                         HStack {
                             Text("₹")
                                 .foregroundStyle(Color.gray)
                             TextField("0", text: $amount)
                                 .keyboardType(.decimalPad)
                         }
                     }

                     Section(header: Text("Category")) {
                         Picker("Category", selection: $selectedCategory) {
                             ForEach(Category.allCases, id: \.self) { category in
                                 Text(category.rawValue).tag(category)
                             }
                         }
                     }

                     Section(header: Text("Date")) {
                         DatePicker("Date", selection: $date)
                     }

                     Section(header: Text("Notes")) {
                         TextEditor(text: $notes)
                     }

            }
            .navigationTitle(transactionType == .expense ? "Add Expense" : "Add Income")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                  ToolbarItem(placement: .topBarLeading) {
                      Button("Cancel") {
                          dismiss()
                      }
                  }

                  ToolbarItem(placement: .topBarTrailing) {
                      Button("Save") {
                          saveExpense()
                      }
                  }
              }
            .alert(alertTitle, isPresented: $showingAlert) {
                  Button("OK", role: .cancel) { }
              } message: {
                  Text(alertMessage)
              }

        }
    }
    private func saveExpense() {
          guard !amount.isEmpty else {
              showAlert(title: "Invalid Amount", message: "Please enter an amount")
              return
          }

          guard let amountDecimal = Decimal(string: amount), amountDecimal > 0 else {
              showAlert(title: "Invalid Amount", message: "Please enter a valid amount greater than 0")
              return
          }

          let newExpense = Expense(
              amount: amountDecimal,
              category: selectedCategory.rawValue,
              date: date,
              notes: notes.isEmpty ? nil : notes,
              type : transactionType
          )

          modelContext.insert(newExpense)
          dismiss()
      }

}

#Preview {
    AddExpenseView()
}
