//
//  OnboardingView.swift
//  ExpenseTrackerPro
//
//  Created by shalinth adithyan on 01/11/25.
//
import SwiftData
import SwiftUI

struct OnboardingView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var startingBalance: String = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        VStack{
            Text("Welcome To")
                .font(.title2)
                .foregroundColor(.gray)
            Text("Expense Tracker")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)
            
            Spacer()
            
            VStack(spacing: 16) {
                              Text("Set Your Starting Balance")
                                  .font(.headline)

                              HStack {
                                  Text("₹")
                                      .font(.title)
                                      .foregroundColor(.gray)

                                  TextField("1000", text: $startingBalance)
                                      .font(.title)
                                      .keyboardType(.decimalPad)
                                      .multilineTextAlignment(.center)
                              }
                              .padding()
                              .background(Color.gray.opacity(0.1))
                              .cornerRadius(10)
                          }
                          .padding(.horizontal, 40)

                          Spacer()
            Button(action: saveAndContinue) {
                              Text("Get Started")
                                  .font(.headline)
                                  .foregroundColor(.white)
                                  .frame(maxWidth: .infinity)
                                  .padding()
                                  .background(Color.green)
                                  .cornerRadius(10)
                          }
                          .padding(.horizontal, 40)

                          Spacer()
                      }
                  }

    private func saveAndContinue() {
              guard !startingBalance.isEmpty else {
                  showAlert(title: "Invalid Balance", message: "Please enter a starting balance")
                  return
              }

              guard let balanceDecimal = Decimal(string: startingBalance),
      balanceDecimal > 0 else {
                  showAlert(title: "Invalid Balance", message: "Please enter a valid amount greater than 0")
                  return
              }

              let settings = AppSettings(
                  startingBalance: balanceDecimal,
                  hasCompletedOnboarding: true
              )

              modelContext.insert(settings)
          }

          private func showAlert(title: String, message: String) {
              alertTitle = title
              alertMessage = message
              showingAlert = true
          }
      }



#Preview {
    OnboardingView()
}
