//
//  ExpenseTrackerProApp.swift
//  ExpenseTrackerPro
//
//  Created by shalinth adithyan on 01/11/25.
//
import SwiftData
import SwiftUI

@main
struct ExpenseTrackerProApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Expense.self, AppSettings.self, CustomCategory.self])

    }

}
