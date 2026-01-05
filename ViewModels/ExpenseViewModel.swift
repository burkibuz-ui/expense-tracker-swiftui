import Foundation
import SwiftUI
import Combine

final class ExpenseViewModel: ObservableObject {

    // 📦 Harcama listesi
    @Published var expenses: [Expense] = []

    private let storageKey = "expenses_key"

    // 🔢 Toplam harcama
    var totalAmount: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }

    // 🚀 App açılırken
    init() {
        loadExpenses()
    }

    // ➕ Harcama ekle
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

    // 🗑 Silme (swipe)
    func removeExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
        saveExpenses()
    }

    // 💾 Kaydet
    private func saveExpenses() {
        if let data = try? JSONEncoder().encode(expenses) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    // 📥 Yükle
    private func loadExpenses() {
        guard
            let data = UserDefaults.standard.data(forKey: storageKey),
            let saved = try? JSONDecoder().decode([Expense].self, from: data)
        else { return }

        expenses = saved
    }
}
