import SwiftUI
import Foundation
import Combine

class ExpenseViewModel: ObservableObject {

    @Published var expenses: [Expense] = []

    private let storageKey = "expenses_key"

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
        saveExpenses()
    }

    func deleteExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
        saveExpenses()
    }

    private func saveExpenses() {
        if let data = try? JSONEncoder().encode(expenses) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    private func loadExpenses() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let saved = try? JSONDecoder().decode([Expense].self, from: data) {
            expenses = saved
        }
    }
}
