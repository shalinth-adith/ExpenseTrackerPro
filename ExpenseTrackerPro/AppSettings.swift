//
//  AppSettings.swift
//  ExpenseTrackerPro
//
//  Created by shalinth adithyan on 01/11/25.
//
import SwiftData
import Foundation


@Model
class AppSettings {
    var startingBalance : Double
    var hasCompletedOnbarding: Bool
    
    init (startingBalance: Double, hasCompletedOnbarding: Bool) {
        self.startingBalance = startingBalance
        self.hasCompletedOnbarding = hasCompletedOnbarding
    }
}
