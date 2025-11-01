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
    var startingBalance : Decimal
    var hasCompletedOnboarding: Bool
    
    init (startingBalance: Decimal, hasCompletedOnboarding: Bool) {
        self.startingBalance = startingBalance
        self.hasCompletedOnboarding = hasCompletedOnboarding
    }
}
