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

      var body: some View {
          NavigationStack {
              List {
                  Button("All") {
                      selectedCategory = nil
                      dismiss()
                  }

                  ForEach(Category.allCases, id: \.self) { category in
                      Button(category.rawValue) {
                          selectedCategory = category.rawValue
                          dismiss()
                      }
                  }
              }
              .navigationTitle("Filter by Category")
              .toolbar {
                  ToolbarItem(placement: .topBarTrailing) {
                      Button("Cancel") {
                          dismiss()
                      }
                  }
              }
          }
      }
  }



#Preview {
    FilterView(selectedCategory: .constant(nil))
}
