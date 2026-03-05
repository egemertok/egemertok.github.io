import SwiftUI

struct ContentView: View {
    @State private var isInMenu = false
    @State private var budgetText = ""
    @State private var budget: Double = 0
    @State private var expenseName = ""
    @State private var expenseAmountText = ""
    @State private var expenses: [(name: String, amount: Double)] = []
    
    enum MenuSection { case main, addExpense, summary }
    @State private var section: MenuSection = .main
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            if isInMenu {
                menuScreen
            } else {
                welcomeScreen
            }
        }
    }
    
    var welcomeScreen: some View {
        VStack(spacing: 16) {
            Image("Logo")
            
            Text("MyBudget Buddy")
                .foregroundColor(.black)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button("Start") {
                isInMenu = true
                section = .main
            }
            .font(.title2)
            .fontWeight(.bold)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
    
    var menuScreen: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 16) {
                switch section {
                    
                case .main:
                    Text("Budget Tracker Menu")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    VStack(spacing: 12) {
                        Text("Enter budget")
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        TextField("Enter", text: $budgetText)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 260)
                        
                        Button("Save Budget") {
                            budget = Double(budgetText) ?? 0
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                        
                        Divider().padding(.vertical, 6)
                        
                        Text("Options")
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        Button("Add an Expense") {
                            section = .addExpense
                        }
                        .buttonStyle(.bordered)
                        .tint(.green)
                        
                        Button("See Summary") {
                            section = .summary
                        }
                        .buttonStyle(.bordered)
                        .tint(.green)
                        
                        Button("Exit") {
                            section = .main
                            isInMenu = false
                        }
                        .buttonStyle(.bordered)
                        .tint(.green)
                    }
                    
                case .addExpense:
                    VStack(spacing: 12) {
                        Text("Add Expense")
                            .foregroundColor(.black)
                            .font(.title)
                            .bold()
                        
                        TextField("Expense name", text: $expenseName)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 260)
                        
                        TextField("Amount (e.g. 12.50)", text: $expenseAmountText)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 260)
                        
                        Button("Add") {
                            let amount = Double(expenseAmountText) ?? 0
                            if !expenseName.trimmingCharacters(in: .whitespaces).isEmpty && amount > 0 {
                                expenses.append((expenseName, amount))
                                expenseName = ""
                                expenseAmountText = ""
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)
                        
                        Button("Back to Menu") {
                            section = .main
                        }
                        .buttonStyle(.bordered)
                    }
                    
                case .summary:
                    VStack(spacing: 10) {
                        Text("Summary")
                            .font(.title)
                            .foregroundColor(.black)
                            .bold()
                        
                        Text("Budget: \(budget, specifier: "%.2f")")
                            .foregroundColor(.black)
                        
                        Text("Total spent: \(totalSpent(), specifier: "%.2f")")
                            .foregroundColor(.black)
                        
                        Text("Remaining: \(calRem(), specifier: "%.2f")")
                            .foregroundColor(.black)
                        
                        Button("Back to Menu") {
                            section = .main
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
            .padding()
        }
    }
    
    func totalSpent() -> Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
    
    func calRem() -> Double {
        budget - totalSpent()
    }
}
