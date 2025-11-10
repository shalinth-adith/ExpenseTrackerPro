//
//  Category.swift
//  ExpenseTrackerPro
//
//  Created by shalinth adithyan on 01/11/25.
//

import Foundation

  enum Category: String, CaseIterable {
      case Food, Transport, Shopping, Bills, Other

      static func allCategories(customCategories: [CustomCategory]) -> [String] {
          var categories = Category.allCases.map { $0.rawValue }
          let activeCustom = customCategories.filter { $0.isActive }.map { $0.name }
          categories.append(contentsOf: activeCustom)
          return categories
      }
  }

