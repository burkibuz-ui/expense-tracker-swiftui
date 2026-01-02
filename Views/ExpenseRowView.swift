import SwiftUI

struct ExpenseRowView: View {
    let expense: Expense

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.title)
                    .font(.headline)

                Text(expense.category)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Text("₺\(expense.amount, specifier: "%.2f")")
                .bold()
        }
    }
}
