//
//  Expense.swift
//  ExpenseTrackerPro
//
//  Created by shalinth adithyan on 01/11/25.
//
import SwiftData
import Foundation


enum TransactionType: String , Codable {
    case income = "Income"
    case expense = "Expense"
}
@Model
class Expense {
    var id : UUID
    var amount: Decimal
    var category : String
    var date: Date
    var notes: String?
    var createdAt: Date
    var type : String
    
    var transactionType : TransactionType {
        get{
            TransactionType(rawValue: type) ?? .expense
        }
        set{
            type = newValue.rawValue
        }
    }
    
    init(id: UUID = UUID(), amount: Decimal, category: String, date: Date, notes: String? = nil , createdat: Date = Date(), type: TransactionType = .expense) {
        self.id = id
        self.amount = amount
        self.category = category
        self.date = date
        self.notes = notes
        self.createdAt = createdat
        self.type = type.rawValue
    }
    
}
