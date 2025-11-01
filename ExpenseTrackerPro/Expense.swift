//
//  Expense.swift
//  ExpenseTrackerPro
//
//  Created by shalinth adithyan on 01/11/25.
//
import SwiftData
import Foundation

@Model
class Expense {
    var id : UUID
    var amount: Decimal
    var category : String
    var date: Date
    var notes: String?
    var createdAt: Date
    
    init(id: UUID = UUID(), amount: Decimal, category: String, date: Date, notes: String? = nil , createdat: Date = Date()) {
        self.id = id
        self.amount = amount
        self.category = category
        self.date = date
        self.notes = notes
        self.createdAt = createdat
    }
    
}
