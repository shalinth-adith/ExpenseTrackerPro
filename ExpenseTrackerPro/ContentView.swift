//
//  ContentView.swift
//  ExpenseTrackerPro
//
//  Created by shalinth adithyan on 01/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showAddExpense = false
    var body: some View {
        NavigationStack{
            VStack{
                BalanceCardView(balance: 8500, spent :1500)
                
                HStack{
                      Text("Expenses")
                      Spacer()
                      Button(action: { }) {
                          Image(systemName: "magnifyingglass")
                      }
                  }

                List{
                    
                }
            }
            .navigationTitle(Text("Expense Tracker"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 16) {
                        Button(action: { showAddExpense = true}) {
                            Image(systemName: "plus")
                        }
                        
                        Button(action: { }) {
                            Image(systemName: "gearshape")
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
