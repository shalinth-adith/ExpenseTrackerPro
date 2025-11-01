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
      @State private var selectedCategory: Category = .Food
      @State private var date: Date = Date()
      @State private var notes: String = ""
    
    @Environment(\.modelContext)private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header : Text("Amount")){
                    HStack{
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

                Section(header : Text("Date")){
                    DatePicker("Date",selection: $date)
                }
                Section(header : Text("Notes")){
                    TextEditor(text: $notes)
                }
                
                
                
            }
            .navigationTitle("Add Expense")
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

        }
    }
    private func saveExpense() {
        guard let amountDecimal = Decimal(string: amount),amountDecimal > 0 else {
            return
        }
        let newExpense = Expense(
            amount: amountDecimal,
            category: selectedCategory.rawValue,
            date: date,
            notes: notes.isEmpty ? nil : notes
        )
        modelContext.insert(newExpense)
        dismiss()
    }
}

#Preview {
    AddExpenseView()
}
