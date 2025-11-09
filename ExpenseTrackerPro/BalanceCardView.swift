//
//  BalanceCardView.swift
//  ExpenseTrackerPro
//
//  Created by shalinth adithyan on 01/11/25.
//

import SwiftUI

struct BalanceCardView: View {
    var balance: Decimal
    var spent: Decimal
    var income: Decimal
    var isCompact: Bool = false

    @State private var animateBalance = false
    @State private var animateIncome = false
    @State private var animateExpense = false
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            cardLayer(opacity: 0.3, offset: -16, scale: 0.92)

            cardLayer(opacity: 0.6, offset: -8, scale: 0.96)

            mainCard()
        }
        .frame(height: isCompact ? 100 : 280)
        .padding(.horizontal)
        .padding(.top, 10)
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: isCompact)
    }

    private func cardLayer(opacity: Double, offset: CGFloat, scale: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(backgroundGradient.opacity(opacity))
            .frame(height: 280)
            .scaleEffect(scale)
            .offset(y: offset)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }

    private func mainCard() -> some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(backgroundGradient)
            .overlay(
                VStack(spacing: isCompact ? 5 : 20) {
                    if !isCompact {
                        Image(systemName: "creditcard.fill")
                            .font(.system(size: 35))
                            .foregroundColor(.white.opacity(0.9))
                    }

                    VStack(spacing: 5) {
                        Text(isCompact ? "Balance" : "Current Balance")
                            .font(isCompact ? .caption : .headline)
                            .foregroundColor(.white.opacity(0.8))
                            .fontWeight(.medium)

                        Text("₹\(formatCurrency(balance))")
                            .font(.system(size: isCompact ? 24 : 48, weight: .bold, design:
.rounded))
                            .foregroundColor(.white)
                            .scaleEffect(animateBalance ? 1.0 : 0.8)
                    }

                    if !isCompact {
                        HStack(spacing: 15) {
                            miniCard(
                                icon: "arrow.up.circle.fill",
                                title: "Income",
                                amount: income,
                                color: Color.green,
                                animate: animateIncome
                            )

                            miniCard(
                                icon: "arrow.down.circle.fill",
                                title: "Expense",
                                amount: spent,
                                color: Color.red,
                                animate: animateExpense
                            )
                        }
                        .padding(.horizontal)

                        progressBar()
                    }
                }
                .padding(.vertical, isCompact ? 10 : 25)
            )
            .frame(height: isCompact ? 100 : 280)
            .shadow(color: Color.purple.opacity(0.4), radius: 20, x: 0, y: 10)
            .shadow(color: Color.blue.opacity(0.3), radius: 15, x: 0, y: 5)
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    animateBalance = true
                }
                withAnimation(.easeOut(duration: 0.8).delay(0.2)) {
                    animateIncome = true
                }
                withAnimation(.easeOut(duration: 0.8).delay(0.4)) {
                    animateExpense = true
                }
            }
    }

    private func miniCard(icon: String, title: String, amount: Decimal, color: Color, animate:
Bool) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundColor(color)
                .scaleEffect(animate ? 1.0 : 0.5)

            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))

            Text("₹\(formatCurrency(amount))")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.15))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
        )
    }

    private func progressBar() -> some View {
        let totalAmount = balance + spent
        let spentRatio = totalAmount > 0 ?
            min(Double(truncating: spent as NSDecimalNumber) / Double(truncating: totalAmount as
NSDecimalNumber), 1.0) : 0.0

        return VStack(spacing: 5) {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 8)

                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            LinearGradient(
                                colors: [Color.red, Color.orange],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * CGFloat(spentRatio), height: 8)
                        .animation(.spring(response: 1.0, dampingFraction: 0.8), value:
spentRatio)
                }
            }
            .frame(height: 8)
            .padding(.horizontal)

            Text("\(Int(spentRatio * 100))% spent")
                .font(.caption2)
                .foregroundColor(.white.opacity(0.6))
        }
    }

    private var backgroundGradient: LinearGradient {
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

    private func formatCurrency(_ amount: Decimal) -> String {
        let number = NSDecimalNumber(decimal: amount)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_IN")
        formatter.maximumFractionDigits = 0
        return formatter.string(from: number) ?? "0"
    }
}

#Preview {
    BalanceCardView(balance: 45000, spent: 15000, income: 60000)
}
