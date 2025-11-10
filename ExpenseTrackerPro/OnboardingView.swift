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
    @Environment(\.colorScheme) var colorScheme

    @State private var startingBalance: String = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    @State private var animateContent = false

    var body: some View {
        ZStack {
            // Background Gradient
            backgroundGradient
                .ignoresSafeArea()

            // Main Content
            VStack(spacing: 50) {
                Spacer()

                // Welcome Section
                welcomeSection

                // Balance Input Card
                balanceInputCard

                // Get Started Button
                getStartedButton

                Spacer()
            }
            .padding(.horizontal, 30)
            .opacity(animateContent ? 1 : 0)
            .offset(y: animateContent ? 0 : 20)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) {
                animateContent = true
            }
        }
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }

    // MARK: - Background Gradient
    private var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: colorScheme == .dark ? [
                Color(red: 0.05, green: 0.07, blue: 0.25),
                Color(red: 0.15, green: 0.04, blue: 0.30),
                Color(red: 0.08, green: 0.11, blue: 0.29)
            ] : [
                Color(red: 0.10, green: 0.14, blue: 0.49),
                Color(red: 0.29, green: 0.08, blue: 0.55),
                Color(red: 0.16, green: 0.21, blue: 0.58)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // MARK: - Welcome Section
    private var welcomeSection: some View {
        VStack(spacing: 16) {
         
            Text("Welcome to")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.white.opacity(0.9))

            Text("ExpenseTracker Pro")
                .font(.system(size: 38, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            Text("Take control of your finances")
                .font(.body)
                .foregroundColor(.white.opacity(0.7))
                .padding(.top, 4)
        }
    }

    private var balanceInputCard: some View {
        VStack(spacing: 24) {
          

            Text("Set Your Starting Balance")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)

            Text("Enter your current account balance")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)

            HStack(spacing: 12) {
                Text("₹")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)

                TextField("10,000", text: $startingBalance)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 30)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.2))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.4), lineWidth: 2)
                    )
            )
        }
        .padding(35)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.15))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
        )
    }

    private var getStartedButton: some View {
        Button(action: saveAndContinue) {
            HStack(spacing: 12) {
                Text("Get Started")
                    .font(.headline)
                    .fontWeight(.bold)

                Image(systemName: "arrow.right.circle.fill")
                    .font(.headline)
            }
            .foregroundColor(Color(red: 0.10, green: 0.14, blue: 0.49))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .shadow(color: .white.opacity(0.4), radius: 15, x: 0, y: 5)
            )
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


