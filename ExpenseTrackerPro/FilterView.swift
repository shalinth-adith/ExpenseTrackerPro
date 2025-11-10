//
//  FilterView.swift
//  ExpenseTrackerPro
//
//  Created by shalinth adithyan on 01/11/25.
//

import SwiftUI
 import SwiftData

 struct FilterView: View {
     @Binding var selectedCategory: String?
     @Environment(\.dismiss) private var dismiss
     @Query private var customCategories: [CustomCategory]

     var body: some View {
         NavigationStack {
             List {
                 Section(header: Text("All Transactions")) {
                     Button(action: {
                         selectedCategory = nil
                         dismiss()
                     }) {
                         HStack {
                             Image(systemName: "list.bullet")
                                 .foregroundColor(.blue)
                             Text("All")
                             Spacer()
                             if selectedCategory == nil {
                                 Image(systemName: "checkmark")
                                     .foregroundColor(.blue)
                             }
                         }
                     }
                 }

                 Section(header: Text("Default Categories")) {
                     ForEach(Category.allCases, id: \.self) { category in
                         Button(action: {
                             selectedCategory = category.rawValue
                             dismiss()
                         }) {
                             HStack {
                                 Image(systemName: getCategoryIcon(category.rawValue))
                                     .foregroundColor(getCategoryColor(category.rawValue))
                                 Text(category.rawValue)
                                 Spacer()
                                 if selectedCategory == category.rawValue {
                                     Image(systemName: "checkmark")
                                         .foregroundColor(.blue)
                                 }
                             }
                         }
                     }
                 }

                 if !customCategories.filter({ $0.isActive }).isEmpty {
                     Section(header: Text("Custom Categories")) {
                         ForEach(customCategories.filter { $0.isActive }, id: \.id) { custom in
                             Button(action: {
                                 selectedCategory = custom.name
                                 dismiss()
                             }) {
                                 HStack {
                                     Image(systemName: getCategoryIcon(custom.name))
                                         .foregroundColor(getCategoryColor(custom.name))
                                     Text(custom.name)
                                     Spacer()
                                     if selectedCategory == custom.name {
                                         Image(systemName: "checkmark")
                                             .foregroundColor(.blue)
                                     }
                                 }
                             }
                         }
                     }
                 }
             }
             .navigationTitle("Filter by Category")
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

     private func getCategoryIcon(_ category: String) -> String {
         switch category {
         case "Food":
             return "fork.knife"
         case "Transport":
             return "car.fill"
         case "Shopping":
             return "cart.fill"
         case "Bills":
             return "doc.text.fill"
         case "Gym":
             return "dumbbell.fill"
         case "Entertainment":
             return "popcorn.fill"
         case "Health":
             return "heart.fill"
         case "Education":
             return "book.fill"
         default:
             return "star.fill"
         }
     }

     private func getCategoryColor(_ category: String) -> Color {
         switch category {
         case "Food":
             return .orange
         case "Transport":
             return .blue
         case "Shopping":
             return .purple
         case "Bills":
             return .red
         case "Gym":
             return .green
         case "Entertainment":
             return .pink
         case "Health":
             return .red
         case "Education":
             return .blue
         default:
             return .gray
         }
     }
 }

 #Preview {
     FilterView(selectedCategory: .constant(nil))
 }


