import SwiftUI
import Combine
import Foundation

class ExpenseViewModel: ObservableObject {

    @Published var expenses: [Expense] = [] {
        didSet {
            saveExpenses()
        }
    }

    private let key = "expenses_key"

    init() {
        loadExpenses()
    }

    func addExpense(title: String, amount: Double, category: String) {
        let newExpense = Expense(
            id: UUID(),
            title: title,
            amount: amount,
            category: category,
            date: Date()
        )
        expenses.append(newExpense)
    }

    func deleteExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }

    private func saveExpenses() {
        if let data = try? JSONEncoder().encode(expenses) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func loadExpenses() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Expense].self, from: data) {
            expenses = decoded
        }
    }
}
