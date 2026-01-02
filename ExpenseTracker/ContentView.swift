import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = ExpenseViewModel()
    @State private var showAddExpense = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.expenses) { expense in
                    ExpenseRowView(expense: expense)
                }
                .onDelete(perform: viewModel.deleteExpense)
            }
            .navigationTitle("Expenses")
            .toolbar {
                Button {
                    showAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddExpense) {
                AddExpenseView(viewModel: viewModel)
            }
        }
    }
}
