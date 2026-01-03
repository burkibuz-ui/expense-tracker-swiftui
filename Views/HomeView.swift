import SwiftUI

struct HomeView: View {

    @EnvironmentObject var session: SessionManager
    @StateObject private var expenseVM = ExpenseViewModel()
    @State private var showAdd = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenseVM.expenses) { expense in
                    ExpenseRowView(expense: expense)
                }
                .onDelete(perform: expenseVM.deleteExpense)
            }
            .navigationTitle("Expenses")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Logout") {
                        session.logout()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAdd) {
                AddExpenseView(viewModel: expenseVM)
            }
        }
    }
}
