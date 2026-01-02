import SwiftUI

struct AddExpenseView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ExpenseViewModel

    @State private var title = ""
    @State private var amount = ""
    @State private var category = "Food"

    let categories = ["Food", "Transport", "Shopping", "Other"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)

                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)

                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
            }
            .navigationTitle("Add Expense")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let value = Double(amount) {
                            viewModel.addExpense(
                                title: title,
                                amount: value,
                                category: category
                            )
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
