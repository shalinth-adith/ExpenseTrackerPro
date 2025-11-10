//
//  Custom Category.swift
//  ExpenseTrackerPro
//
//  Created by shalinth adithyan on 10/11/25.
//

import SwiftData
 import Foundation

 @Model
 class CustomCategory {
     var id: UUID
     var name: String
     var usageCount: Int
     var createdAt: Date
     var isActive: Bool // true when usage >= 4

     init(id: UUID = UUID(), name: String, usageCount: Int = 1, createdAt: Date = Date(),
 isActive: Bool = false) {
         self.id = id
         self.name = name
         self.usageCount = usageCount
         self.createdAt = createdAt
         self.isActive = isActive
     }
 }
